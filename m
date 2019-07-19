Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4006EBC2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfGSUul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 16:50:41 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39827 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfGSUul (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2019 16:50:41 -0400
Received: by mail-wr1-f44.google.com with SMTP id x4so33411806wrt.6
        for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2019 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7pGsGeHgvRqpZd9Q2aYyzAj3D4TGPVj4fZTmgknNzNc=;
        b=O+/KwM91KVEPHVAlPe3/BW6cEwuPv05zFQV0oAXe4dt0boFRps2N1JY7yInRSRK3O+
         ggTYnHb80Frlz5WvhRvpwpLr1UC1HjjyAaqepasX8wsZjO9zLw4mW8051K09EmMd5VkP
         l19qOAXNkAcJg7PXj4PJ6marK74W1G6/BWCHf4cfHI16xHD88XAeawXh8NMWzv13ZlIs
         m+bcA43ZjmDGNzmy+izVKLJZkPN4+IkD5IRMSO4EVAQ9UUBTT37HYfcV+3iJcDSR8xt7
         MaF2jKepb0gmflIivw/nUI6K/0F1tS7fbOIOM6GhsSRNHb9vJZA+WARWQpuftIrzaSHV
         FZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7pGsGeHgvRqpZd9Q2aYyzAj3D4TGPVj4fZTmgknNzNc=;
        b=FehfG2gbRLf0doelWHXYXZlo1IPnTw077CIzMuxNZSoT9DqcPFiG+BLhTw4WkqDMBf
         VsFjDoPgW4RjDRNs8dwMsD5gxKAka4SQz8CeqMbzZgiaYti3EXjaoE1Ysrgs0wxDsaqS
         Flb+qkmrTpeoBnMpdI9GewC/MzhpfYK2i21OOBM75I6FRprPe4x06jhEvyYXehRefZ5G
         OXfWeQT8J7FdMtq2hBeyHUjaOf+32orx/EXBJ5dcoHrzTXrAtagy7U8i0vNacLG85Gn2
         LReGpihIlg5DqPE99NSzbaPq/qz7IIjL7XI4YUDf3C2DLvpCVIpFY4q6AbQGW+8KminB
         pVFQ==
X-Gm-Message-State: APjAAAUv1cWJPoEWb7efMevAwJrUc9/jx/wL5Vl1RpL02keG8g38ebce
        dTbW2AZQKbMp223POVV5Rj5m4Nlmv4JvtSEyPk/yxx6K
X-Google-Smtp-Source: APXvYqzcx82FeOf8HZNjU4M+XoeBDU4OChebIPPkB6kTMUdAgOAhTL6lvl8dYXS5iuXMgcyX4rdGxIeKFdjbhxnTphs=
X-Received: by 2002:adf:e941:: with SMTP id m1mr48927259wrn.279.1563569438985;
 Fri, 19 Jul 2019 13:50:38 -0700 (PDT)
MIME-Version: 1.0
From:   Kartik Kulkarni <kartik.koolks@gmail.com>
Date:   Sat, 20 Jul 2019 02:20:28 +0530
Message-ID: <CAMz8oh3q9OsyZN5F5SxWFttCgGfjW2jaszT1EN8TTtO-NHuO1w@mail.gmail.com>
Subject: problem with driver with driver name and version
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello there,
I wanted to patch the driver for  ad7280a  found at
/opt/linux-kernel-dev/iio/drivers/staging/iio/adc and found a few
anomalies which I felt needed to be asked before the patch was
submitted.

1.
```
tatic struct spi_driver ad7280_driver = {
        .driver = {
                .name   = "ad7280",

...

```
the part of the device id says ad7280 instead of ad7280a which is the
name of the driver file and looking at the Datasheet there's different
datasheet for ad7280 and ad7280A and does not mention compatibility
with each other.(I might be wrong but one had spi interface for 48
channels and the other has spi interface for 300 channels so I think
it might not be compatible)

Note: The spi device id contains "ad7280a" and not "ad7280"
QUESTION:
Should I send a patch to correct the .compatible with ad7280a instead?
as a different patch and send another patch which I am working on
(about of_match which is not present) and add the of_match_array to
contain the device "ad7280a"

or is the file correct and I just send a patch about of_match_devices
with "ad7280"

Regards,
Kartik Kulkarni
