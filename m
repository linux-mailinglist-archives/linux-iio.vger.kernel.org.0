Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063CC34EE0B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Mar 2021 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhC3Qha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhC3QhY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Mar 2021 12:37:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71CC061574
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 09:37:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f16so20645226ljm.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ZE/q1GCahIerSH8xZlTpJrld48yQuMwSq+TUXGYQWE=;
        b=REhjx7ya0eJXssI64KNhwYguBgq5m41OTi1L760SNtCfjzJb4UqJ/gdLcvQIErW0/Z
         Q/nQVzgZEQ0lDLyR0IF8LAQJ418VU15/x/AfFO68Gm2ABaP9nnNQ6mJYIqlxF3o8Lu00
         CTlAkT+O+4vrjsfVDBSickKe+K4y2tpKQXt9QxQPL+YNJH2coNbniMPnOuMqIziXXOXe
         +MQpPZETNjVG8ka+YxtvHY9gA+yghWDem3qLnprnidbpL/shD6Ns4u5VVpVExF/j4QNJ
         jPbxlpctOhv4CTHgZ8gduHkeZucjdC9EA84S3MwiQ5osTR6u5CKFPrOxpgnkZWPxLup/
         oK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ZE/q1GCahIerSH8xZlTpJrld48yQuMwSq+TUXGYQWE=;
        b=hHWu7zua1pBB8kNFLGcGoXjlvjQ6XjP+17e0R8vAiuJ2GV3AZi1lxNtOw6AoMSXo0n
         JY2ntrLpVv/VgeCu/+SvuaF7KfF7+HXkKqSqCXaP0Omln4Rv0QbqlspG/pVl/LmraMO/
         lyigvUp61NZunIpcy6NA5LZ6MV18qF0/jNMtkFYlWG5Wp8fNYtU/gsOW6ga8tsc1DWhL
         YmWMVIQvv/nmVpH2/g2S1Y6bsKweLEeDX0nctc8yMF+ZJJn/qG+23KYnC++EChQxZI5i
         lzZ/eaEORKwC75BQ6dVyx3QOEGbjermw013QWyrxpPD8te6vYGFrtInJzKztDPnQEuj1
         UXAw==
X-Gm-Message-State: AOAM532I+e2TLsKHErVwcKl8mzlxX1255fMM15FmF16jnOvysagkjZmO
        VSKcxtsfSY5ttjmpH57Hv4uw9Xr4wtasP1qgToXWCjaAU0D1ZA==
X-Google-Smtp-Source: ABdhPJybtTgpUWo73P0UG3tFarQFUHmH9ZG4JFXTt4Ht0r1dZQ2Oz2zpl8jdht89/ew4WfEmHxzBaqbWX/n7PFmQLWM=
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr22113689ljk.161.1617122241939;
 Tue, 30 Mar 2021 09:37:21 -0700 (PDT)
MIME-Version: 1.0
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 30 Mar 2021 22:07:10 +0530
Message-ID: <CANk7y0j89CFD7y2sY8B+H+YQ8P-w3EXmjzSL2=UitLpcgjYttQ@mail.gmail.com>
Subject: IIO: GSOC 2021 Project Proposal
To:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Everyone, I am Puranjay Mohan a junior at SRMIST, India, pursuing
electronics and communications engineering. I wish to participate in
the GSoC 2021 as a part of Linux Foundation, IIO Workgroup.

I have been contributing to the Linux kernel and have more than 30
accepted patches. I was a mentee in the Linux Kernel mentorship
program where I worked under the mentorship of Bjorn Helgaas(PCI
maintainer) on PCI latency tolerance reporting.

I have completed the IIO_tasks,  for learning the IIO Subsystem I am
working on an IIO Driver for TI's TMP117 temperature sensor, the patch
can be seen here:-
https://lore.kernel.org/linux-iio/20210320064509.119878-1-puranjay12@gmail.com/

For GSoC 2021, I have chosen the ADXL355 Accelerometer as my device of
choice, but I am ready to work on another device if Analog Devices,
Inc. wants to get the driver for another device. I choose this device
because I saw a post on ADI Engineer Zone asking for its driver.

I know it is too early, but I have written a proposal and wish to get
your comments on it so that I can improve it further.
Here is the google docs link, please add your comments on
it:-https://docs.google.com/document/d/16xusxryh_3F7Svje14fD7dAx6qzEN4fbFPpvvdJB09A/edit?usp=sharing

-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
