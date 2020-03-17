Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F307A188EE1
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQUVs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:21:48 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:40604 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgCQUVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:21:48 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584476024;
        bh=fkavbtJNddXObOK+wGDRWdGI8TX7B55NSD86i1yF92k=;
        h=From:To:Cc:Subject:Date:From;
        b=oty6K2xpVVD7boKwUwtsLgaS/1sSfUY04pqkBrb2Boaf95sgoNqFii/MidnAWxDrl
         AvdKP0DbV9tPizWt4fuj1YU/TajD3/V6Kj3Ua6tvkZBEK1ISs4hALGN86b3RS4LgbP
         W/mR0U48ynVVfPsEM6QYemmph/HOL7AAXas05xX05odxb+Won4HnlfelX4jzPGCvyy
         w1FD4n1WBEB2WC2uoQ33X3F/fZ6QkyUTMTvyV45drJib3HcGA3QMCzbNr7CdcIsH1u
         Gmyz93JIzmiw8W03h8qcLLobxZlYvQSyICS7GT+5XsGoDbCa354xCxlOAQxxTdVAMs
         UrM3Qe6ZFVR8Q==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH 0/2] Maxim MAX1241 driver
Date:   Tue, 17 Mar 2020 22:17:08 +0200
Message-Id: <20200317201710.23180-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello!

This patch series adds support for the Maxim MAX1241, a 12-bit,
single-channel, SPI-connected ADC. It's a pretty sturdy ADC that I've
used for some time now and I figured my driver may be useful to others
as well.

I originally thought I might get this under the max1027 driver but the
124x family is different enough that shoehorning it in there didn't seem
like a good idea. The 1241 has a single channel, no FIFO, uses a
different mechanism to signal conversion start and has a low-power
operation mode which it uses in a pretty different way. This is actually
closer to MAX111x, but those also have a pretty different signaling
convention.

Needless to say, though, if anyone who is more familiar with this
situation disagrees and wants to point me in the direction of the
appropriate driver, I'm happy to make the changes there instead of
providing a separate driver.

Also please note that I am somewhat unfamiliar with the idioms of the
IIO subsystem's tree. Jonathan Cameron was kind enough to give me a few
pointers but there are a few questions I didn't bother him with (so I'm
guess I'm gonna bother you instead now).

1. There are two ADCs in this family, MAX1240 and MAX1241. This driver
only supports the MAX1241. The scaffolding to get MAX1240 support is in
there, but I didn't have access to a MAX1240 and I didn't want to submit
untested code for review. Can we add MAX1240 support later, or should I
do it from the very beginning? Either way is fine by me (I'm just a
little concerned about how quickly I might *get* a MAX1240 these
days...)

2. Looking at other drivers, it seems to me that, on ADCs that require
an external reference, it's customary to make a voltage regulator a
required property in the DT bindings. Am I correct here?

3. checkpatch.pl warns me that the MAINTAINERS file might need
updating. I'm not sure what the appropriate thing to do is here -- I can
maintain this driver indefinitely (I am actively using it anways) but
it's a 200-line driver, does that warrant inclusion in MAINTAINERS?

My apologies if anything here is distinctly bad -- this isn't the first
time I'm writing kernel code but it's definitely the first time I'm
sending ay upstream. Any bugs are due to my own incompetence, everything
else is just temporary ignorance :-).

Thanks,
Alex

Alexandru Lazar (2):
  iio: adc: Add MAX1241 driver
  dt-bindings: iio: adc: Add MAX1241 device tree bindings in
    documentation

 .../bindings/iio/adc/maxim,max1241.yaml       |  60 +++++
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 215 ++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.1

