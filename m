Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7769197F22
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgC3O5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:57:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46223 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgC3O5K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:57:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so21960619wru.13
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2020 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIymYmVmQjUInoapHdc+0DX1p7FbkjP50QMxhj5e7MU=;
        b=FgXR1Ebxfe1YlE+JQ7oNvcmNmjpq3vXOrKdSmuv9Y1AuKOadsne8Rd2GXwHXmowDAh
         tcLxIGje5TrLTmcCaAwQG/lfgpTxaoj1FjPVUv5bEQYNsfdeCuzEObvZYbsfoLX9TbVa
         KY+6kjoTCl2IAl+lJiCid1f+/YWjHX0xs08SOv3BdTbk6XifbS5dFKRhRfjel+DO4w1B
         TyAIwBqlSiAnGyv/CSjCaYLXRM5oid7hZg9bq7cYKtwWV52my0s7Wwwn/Hw31ARrL4IS
         SkIb1Xpi+frI9mQltQvp1qx7W8zYCSiIKK9633Jz7LxtbODqyi42MWF2uatIaoooa053
         lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIymYmVmQjUInoapHdc+0DX1p7FbkjP50QMxhj5e7MU=;
        b=O9OPcivHhyN3bUO4vQ6G637y8hPQrmAf/naojvFsvf/Yhloes+ziTPj/9rMO0wi2ZI
         U6gdSUO+nnmbupdXPY26hJRdRnIMH5iVnwwoDBPGfpDzAg0qNmJ5L0svhcpJN9TPazqu
         jdckwHTvoGS8tqKylOVh7Sz3xMRFnIdrpi+hWFJrnZ+j3in9PGffuO04nkjQ50O40WAe
         lNRtKKYB43FEBRN/BYyctUP0zW1MIqNYPOWu5d1I78bc12Q5czSqvM71OCtohYiXEYPZ
         XO2LwQNelTNqljpY8jjvK7duuZREpGhDkaXQfI67tKg7YkN7QZefqSwMDEps9HfsVSW/
         Tl/Q==
X-Gm-Message-State: ANhLgQ34oHzB2Zq6EKWpELlvCWZCvjNPAIkTV75qL9oVt0tODhRmCaEq
        3p44plZpdoCYyg32ay3STzgM3Nx/
X-Google-Smtp-Source: ADFU+vv5dYg+y0/XOpeOQmzxvg5p8AVW07JvnS1BAgbgXIM34RTuZeZDRq6fGistrye1T8ywY7YD0Q==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr15332570wrq.421.1585580228170;
        Mon, 30 Mar 2020 07:57:08 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id y200sm21584944wmc.20.2020.03.30.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:57:07 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
        lars@metafoo.de, dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 0/3] iio: buffer: add output buffer support for chrdev
Date:   Mon, 30 Mar 2020 17:57:02 +0300
Message-Id: <20200330145705.29447-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[This description is also present on patch 3/3, there have been some
cosmetic stuff since that one that I did not remove. These patches
probably won't make it in a final version, but they're there because
I changed my mind a few times and got to this RFC]

There have been some offline discussions about how to go about this.
Since I wasn't involved in any of those discussions, this kind of tries to
re-build things from various bits.
It's incomplete work, since I don't have a clear idea of what the accepted/acceptable
approach would be.

1. First approach is: we keep 1 buffer per device, and we make it either
in/out, which means that for devices that for devices that have both in/out
2 iio_dev instances are required, or an ADC needs to be connected on the in
path and a DAC on out-path. This is predominantly done in the ADI tree.

2. One discussion/proposal was to have multiple buffers per-device. But the
details are vague since they were relayed to me.
One detail was, to have indexes for devices that have more than 1
buffer:

Iio_deviceX:
        buffer
        scan_elements

Iio_deviceX:
        BufferY
        scan_elementsY
        BufferZ
        scan_elementsZ

I am not sure how feasible this is for a single chrdev, as when you look at
the fileops that get assigned to a chrdev, it looks like it can have at
most two buffers (one for input, out for output).

Multiplexing input buffers can work (from ADCs), but demultiplexing output
buffers into a DAC, not so well. Especially on a single chrdev.

Question 1: do we want to support more than 2 buffers per chrdev?

This is what ADI currently has in it's tree (and works).

Example, ADC:
 # ls iio\:device3/buffer/
 data_available  enable  length  length_align_bytes  watermark
 #  ls iio\:device3/scan_elements/
 in_voltage0_en  in_voltage0_index  in_voltage0_type  in_voltage1_en  in_voltage1_index  in_voltage1_type

Example, DAC:
 #  ls iio\:device4/buffer/
 data_available  enable  length  length_align_bytes  watermark
 # ls iio\:device4/scan_elements/
 out_voltage0_en     out_voltage0_type  out_voltage1_index  out_voltage2_en     out_voltage2_type  out_voltage3_index
 out_voltage0_index  out_voltage1_en    out_voltage1_type   out_voltage2_index  out_voltage3_en    out_voltage3_type

The direction of each element is encoded into the filename of each channel.

Another question is:
 Does it make sense to have more than 1 'scan_elements' folder?
 That is, for devices that would have both in & out channels.

For 'buffer' folders I was thinking that it may make sense to have,
'buffer_in' && 'buffer_out'.

So, one idea is:

Iio_deviceX:
        buffer_in
        buffer_out
        scan_elements

Currently, this patch kind of implements 2 buffers per iio_dev/chrdev.
But the format is:

Iio_deviceX:
        buffer_in
        buffer_out
        scan_elements_in
        scan_elements_out

Obviously it shouldn't work as-is [as it wasn't tested], but at least gives
some glimpse of where this could go.

3. A side question is about the 'iio_buffer -> pollq' field. I was
wondering if it would make sense to move that on to 'iio_dev  pollq' if
adding multiple buffers are added per-device. It almost makes sense to
unify the 'pollq' on indio_dev.
But, it looks a bit difficult, and would require some more change [which is
doable] if it makes sense for whatever reason.
The only reason to do it, is because the iio_buffer_fileops has a .poll =
iio_buffer_poll() function attached to it. Adding multiple buffers for an
IIO device may require some consideration on the iio_buffer_poll() function
as well.

Alexandru Ardelean (3):
  iio: core: rename 'indio_dev->buffer_list' ->
    'indio_dev->active_buffers'
  iio: buffer: extend short-hand use for 'indio_dev->buffer'
  iio: buffer: add output buffer support for chrdev

 .../buffer/industrialio-buffer-dmaengine.c    |   3 +-
 drivers/iio/industrialio-buffer.c             | 267 +++++++++++++-----
 drivers/iio/industrialio-core.c               |   5 +-
 include/linux/iio/buffer.h                    |   9 +
 include/linux/iio/buffer_impl.h               |   7 +
 include/linux/iio/iio.h                       |  12 +-
 6 files changed, 225 insertions(+), 78 deletions(-)

-- 
2.20.1

