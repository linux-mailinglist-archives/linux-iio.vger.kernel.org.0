Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7343A517E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 02:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFMAfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Jun 2021 20:35:44 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:46605 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMAfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jun 2021 20:35:44 -0400
Received: by mail-il1-f172.google.com with SMTP id v13so8929200ilh.13
        for <linux-iio@vger.kernel.org>; Sat, 12 Jun 2021 17:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7Y2HtKU+L/p4Ln5gVX/+ovzsjaaE/+QSo8iipIHioH0=;
        b=rV6ttDPb6NUYGG7QqC0WlGlJLw60exq00/XKFaAJTj6EaraZ8OxL4YC/FU4ybjYdQ1
         yKuj8YG9frvH2+TEoLimQKH3bTo+48PCwCI9aZfoW1EWJs/lNIjJCJQw1zlFIgfIAhk0
         jf8j4I0zT+DY2shc9u8JLjQ32vmvYLJXrmX72c8nlpbzuFD/1ebWIXPNLccuOQmE1jVb
         h52wygBV2obw9AHOa2G59EkI3G7yiOX3UWmhW3ED1xBazqzToCEXJSA3IX+XYgXiWUTO
         e1Jjk9uR6iILVS8xy46iamtVTKRh31AZQKBN69/+AtHsrnwpHe56/acNxDIABQD0/4G2
         KAgA==
X-Gm-Message-State: AOAM530IhzWWaMc0KGU/pGzvnRJcKz9zgIBhUgVg8+FvqYbm4n8CkjTC
        mmpn5QX73HcOVgweOTRvrKzC1qcAueOpL+090fOjgoWQTzvR8A==
X-Google-Smtp-Source: ABdhPJxk5/5QdgU9Gs7HD3PF59q5DyOTEqtsb/33LOMTX0gzrJUET+lzyTseAIdYTz+bn/Td3pJl6ezlGo0tJDo79UI=
X-Received: by 2002:a92:c546:: with SMTP id a6mr8003481ilj.39.1623544423758;
 Sat, 12 Jun 2021 17:33:43 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Roberts <alex.roberts@ieee.org>
Date:   Sat, 12 Jun 2021 19:33:32 -0500
Message-ID: <CAPkENw-TUC85hUMTJnkm2zvsk_NR_+8f3XngWaNGAWLkD8MNJA@mail.gmail.com>
Subject: using dma buffers for SPI adcs
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I am learning how to use and write iio device drivers for ADCs. It seems
most of the support is tied to FPGA based SoCs where ADCs can make use of
Analog Devices SPI Engine and AXI IP. I'm looking at the AD7768-1 driver on
the Analog Devices fork for example.

How does one use dma buffers for generic ARM processors for an ADC attached
to a dma-enabled SPI port.. for example a Beaglebone Black or Raspberry PI?
Is this even possible or something that makes sense? The goal is of course
to use DMA to avoid interrupting the processor for every conversion.

I tried using the ADI driver, but get a ENODEV error when requesting the
dma channel because there is not a "dmas" entry in the device tree node for
the ADC, however it's parent SPI node does have dma entries.

Thanks,
Alex.
