Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F6C6D4C6C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjDCPtG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjDCPtE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 11:49:04 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC181709;
        Mon,  3 Apr 2023 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680536888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BEseiNY15McK7cM9hqrQ6iJMRNpnoZM7y9fQeUbgP/w=;
        b=w3+hjfKairDEnqBYIQklEwG5hfr8XxlLBrjjXfRcfnyk82kg5dEbobFrtsIVzK/0N4ohNr
        SbB2G1UCv6o4C/p6BypakA4C8wo6hKblMfoqeFyPpBKaiT4WqYaARtZThOH96kbS7B8KWm
        GIsWk1BPZB6jrmqEINrmBM4nUXJDk8g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 00/11] iio: new DMABUF based API, v3
Date:   Mon,  3 Apr 2023 17:47:49 +0200
Message-Id: <20230403154800.215924-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Here's the v3 of my patchset that introduces a new interface based on
DMABUF objects to complement the fileio API, and adds write() support to
the existing fileio API.

It changed quite a lot since V2; the IIO subsystem is now just a DMABUF
importer, and all the complexity related to handling creation, deletion
and export of DMABUFs (including DMA mapping etc.) is gone.

This new interface will be used by Libiio. The code is ready[1] and will
be merged to the main branch as soon as the kernel bits are accepted
upstream.

Note that Libiio (and its server counterpart, iiod) use this new
interface in two different ways:
- by memory-mapping the DMABUFs to access the sample data directly,
  which is much faster than using the existing fileio API as the sample
  data does not need to be copied;
- by passing the DMABUFs around directly to the USB stack, in a
  device-to-device zero-copy fashion, using a new DMABUF interface for
  the USB (FunctionFS to be exact) stack, which is being upstreamed in
  parallel of this patchset [2].

As for write() support, Nuno (Cc'd) said he will work on upstreaming the
DAC counterpart of adc/adi-axi-adc.c in the next few weeks, so there
will be a user for the buffer write() support. I hope you are okay with
this - otherwise, we can just wait until this work is done, and I still
benefit from sending this patchset early to get feedback.

Finally, the dmaengine implementation for this new interface requires a
new dmaengine API function, since dmaengine_prep_slave_sg() will always
transfer the full scatterlist unconditionally, while we want to be able
to transfer an arbitrary amount of bytes from/to the DMABUF. Since
scatterlists seem to be going away soon, the new API function will take
an array of DMA addresses + lengths. I am open to suggestions if anybody
(especially Vinod) have a better design in mind.

Cheers,
-Paul

[1]: https://github.com/analogdevicesinc/libiio/pull/928
[2]: https://lore.kernel.org/linux-usb/425c1b8ea20002c6344a574cd094b4c715c67ba6.camel@crapouillou.net/T/#t

---
Changelog:
* Patches 01-02 are new;
* Patches [03/11], [05/11] didn't change;
* Patch [04/11]:
    - Reorganize arguments to iio_dma_buffer_io()
    - Change 'is_write' argument to 'is_from_user'
    - Change (__force char *) to (__force __user char *), in
      iio_dma_buffer_write(), since we only want to drop the "const".
* Patch [07/11]:
    - Get rid of the old IOCTLs. The IIO subsystem does not create or
      manage DMABUFs anymore, and only attaches/detaches externally
      created DMABUFs.
    - Add IIO_BUFFER_DMABUF_CYCLIC to the supported flags.
* Patch [09/11]:
    Update code to provide the functions that will be used as callbacks
    for the new IOCTLs.
* Patch [10/11]:
    Use the new dmaengine_prep_slave_dma_array(), and adapt the code to
    work with the new functions introduced in industrialio-buffer-dma.c.
* Patch [11/11]:
    Update the documentation to reflect the new API.

---
Alexandru Ardelean (1):
  iio: buffer-dma: split iio_dma_buffer_fileio_free() function

Paul Cercueil (10):
  dmaengine: Add API function dmaengine_prep_slave_dma_array()
  dmaengine: dma-axi-dmac: Implement device_prep_slave_dma_array
  iio: buffer-dma: Get rid of outgoing queue
  iio: buffer-dma: Enable buffer write support
  iio: buffer-dmaengine: Support specifying buffer direction
  iio: buffer-dmaengine: Enable write support
  iio: core: Add new DMABUF interface infrastructure
  iio: buffer-dma: Enable support for DMABUFs
  iio: buffer-dmaengine: Support new DMABUF based userspace API
  Documentation: iio: Document high-speed DMABUF based API

 Documentation/iio/dmabuf_api.rst              |  59 +++
 Documentation/iio/index.rst                   |   2 +
 drivers/dma/dma-axi-dmac.c                    |  41 ++
 drivers/iio/adc/adi-axi-adc.c                 |   3 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 331 +++++++++++---
 .../buffer/industrialio-buffer-dmaengine.c    |  77 +++-
 drivers/iio/industrialio-buffer.c             | 402 ++++++++++++++++++
 include/linux/dmaengine.h                     |  16 +
 include/linux/iio/buffer-dma.h                |  40 +-
 include/linux/iio/buffer-dmaengine.h          |   5 +-
 include/linux/iio/buffer_impl.h               |  22 +
 include/uapi/linux/iio/buffer.h               |  22 +
 12 files changed, 939 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/iio/dmabuf_api.rst

-- 
2.39.2

