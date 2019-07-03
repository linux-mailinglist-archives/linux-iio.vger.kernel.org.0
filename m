Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4725EF43
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2019 00:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGCWsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 18:48:41 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45426 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfGCWsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 18:48:41 -0400
Received: by mail-io1-f44.google.com with SMTP id g20so1065255ioc.12
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2019 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=NwktkXSR1DxuyYPN3DC6uMCL2twxlgUZszhmg1eGGFA=;
        b=Q5k5hoMlY+kdNin/ogL05c8/e9m+MKvtI8BsVAOMFtiHrqkTboDbvWBL2xqPGIxtfn
         qSedXTqAskjRia3VtaJBw/TkAXzQ9+qI5f7okdR1iSXDEYu43A/rgQ4J7liEXsoy7waY
         YTEUlCByHilp/0idp74ChIrjgyIrdiG0ujNzr2NIGh6IXV6Ej60z7qXc8r6I2jHo/Pw6
         qmm1w/7C7bTGMtgci28nOXl+EyjCHrQn7y8gRF0b20ANDjom3wlAF6q8EN3iNk6cKvwA
         DUdYYUPOeetqsUo9HeigYLmEjrYQtp4LrCIb9/IiI4oL68xT8HVhKDs3kTrM2VFw7D5U
         d5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NwktkXSR1DxuyYPN3DC6uMCL2twxlgUZszhmg1eGGFA=;
        b=mju5VA8mz92sn9Dl+iXblyv5TPTAJFOwBsSggkDEDeKA/OZhqDaGONGT98m+P9Sq5P
         5nqrXo4eq0EZSqh00h9mwWLuHk9pR0/9oeAgm2B10ZGl9Q0CfOzXUrlKhe68o0iJzdSX
         h3SbGr27qcxcgtl4VmOM2gwy5EFUkRlHD1SHvXSejjj3eHDLXc/m8NeL/QF8tTNfa2Tx
         0tmPGBi4cRBOr/8pBmPIXeTsRF6j4cClP1y7Pehjr587k5ioVVz4z5t9/oUp+nAdZYXV
         l5X30TFEfiHrMseg5NWOPWDBLewU7OSEIui1fM0Qf6GXMPH6iQ0FN3ly2PfEM/sBRU9B
         Ximw==
X-Gm-Message-State: APjAAAW9pX5u1J7JMc/Mztfp3JWO4YKP3wK0DdwB8vVGgVUBWq2X/tM2
        uA386umt/nPrjvoG5NV6KiiPLMGlOyzB1dPCnRvcB2NfduvvMQ==
X-Google-Smtp-Source: APXvYqx35T409yVPE0dXEVk/8CwhemddaDH6gppo7fA66fKY2+AOKs0tgCThIDzsU82pjsHMm0ddT3y2r5jt7afE31Y=
X-Received: by 2002:a5d:9291:: with SMTP id s17mr10875203iom.10.1562194120024;
 Wed, 03 Jul 2019 15:48:40 -0700 (PDT)
MIME-Version: 1.0
From:   Bobby Jones <rjones@gateworks.com>
Date:   Wed, 3 Jul 2019 15:48:29 -0700
Message-ID: <CALAE=UBN7ZPGTHB_jgSje0zG3mCvE8auW1FTrbjn=KbJzN_How@mail.gmail.com>
Subject: FXOS8700 Accelerometer/Magnetometer Support
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello linux-iio,

I'm interested in adding support for the FXOS8700 accel/mag device. I
was curious if there had already been an effort in mainline to add
support and could not find anything in the latest pulled version of
the testing branch. However looking at the list archive I saw an email
back in 2015 from Utkarsh who asked about implementing a driver for
the same device [https://marc.info/?l=linux-iio&m=142920413702776]. My
question for Utkarsh (if you're still reading this, I get a bounce on
your address) and the greater linux-iio mailing list is if there had
been any further effort since then that I can help finish?

Otherwise as someone new to driver development in general, I'm looking
for any advice to get me started. I did see a NXP aka Freescale driver
[https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/misc/fxos8700.c?h=imx_4.19.35_1.0.0]
for the device but it doesn't appear to follow the iio api from what I
can tell. Is it worth taking that driver and trying to get it to fit
into the IMU api or should I start from scratch?

Thanks,
Bobby Jones
