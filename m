Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6C199CC5
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCaRZK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:25:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39253 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgCaRZK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:25:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so4587824pgb.6;
        Tue, 31 Mar 2020 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CF+RVRZ5+EBDJ1PwDAIZhgsPHAgdEwo97U5c4uthYQ=;
        b=O4KTcb1e4nvjWYiYxqstR4fipYRBssCwH7Y8yjsIfaVNJDiV7zknVfPPU6zlKJpUxr
         WAqWMtljzkcWjfYQAG0+4THRRKu3x8LL6SQySS6RO6GY/tSECu0M9VogTZPHf9Vbc4tw
         AXTzX+ChZ8l0a46BbTQ3PqIHFslyqGKvTze9llF3NCAjDrdYoZGr3WkaMDdJB9tDoDLK
         BkGikRcxZ1Ha4il6nsI+bkDKCjxxx7PmUWgarTGMWCtbmjyo/O4VQftsAHh9UlPnImkz
         VFpNyIJ44FNjqJxCb5rJoGjjD7aCGJ5TwYBnOS86C7fVpaytQdw+FM1ckK4FXMNaiMgV
         7SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CF+RVRZ5+EBDJ1PwDAIZhgsPHAgdEwo97U5c4uthYQ=;
        b=IbnhJ6BOQVCMgM5K/B42wmsPEzcDFiFT0IZN/YJVdzkoihbGFiKJjHy3R6of9TbZHo
         fpSfqseW9lxSsZL/pABI5aIT1Lb27+pgY/oBt/V5Ab+ZcbkBjwNB8RRaq5BsUDBWY04u
         sPH0zlzr707oDy4dZhm9Kvr4R5l6FwJJ1r9f6K5UPSjnymQlz3UyykyI+/ewr2IoTUxd
         9T0TceNPRF5GNZJNBGakBtUMNDlTrj4KhZkjC8pR/RrS34FEIH9bJgu/3Hup3HCgkRlJ
         xxMSwhB4SMpbwMAElHJstioSzjb92HSJARmL3TwIMMIS95/xPKjSdj4AFOcpHxGh6bV9
         ibiQ==
X-Gm-Message-State: ANhLgQ2OvgKdGVJPhQWaUoPt+nG1R8W78iEoHAPSGrj0nwHU05qbnzZA
        XSts6GJy3L2+8lDorKjiaKlfzURYrqLkFNGCS74=
X-Google-Smtp-Source: ADFU+vvJ58xFp7fAmN/IlP9pLsjdwYgUeX7CEW9cTr9ulw07E6JB4eftS0SoxlIHYsnAS1X1h2HA2MGKLqsp5Ik9Kkw=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr18682395pfj.130.1585675507170;
 Tue, 31 Mar 2020 10:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
 <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com> <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
 <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
In-Reply-To: <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:24:59 +0300
Message-ID: <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     Richard Neumann <mail@richard-neumann.de>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        Shyam-sundar.S-k@amd.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 4:26 PM Shah, Nehal-bakulchandra
<nehal-bakulchandra.shah@amd.com> wrote:
> On 3/31/2020 6:01 PM, Richard Neumann wrote:
> > Not a real review, but your patch series seems to be repeating a lot
> > from drivers/i2c/busses/i2c-amd-mp2*.
> > Is there any chance we could re-use the code?
> > E.g. the AMD_C2P_* definitions from drivers/i2c/busses/i2c-amd-mp2.h?
>
> Thanks for the mail. Yes there are some common structures, however as of now we have kept separately considering both
>
> are part of different sub systems. But may be will consider this input for future enhancement.

It can be done in a form of shared definitions at least in
include/linux/platform_data/x86/amd-mp2.h or alike ...

-- 
With Best Regards,
Andy Shevchenko
