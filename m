Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B863374D2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 15:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhCKOAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 09:00:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:50481 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCKN76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 08:59:58 -0500
Received: from [192.168.1.155] ([77.4.9.157]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmDAc-1m2S7B0CQa-00iFI0; Thu, 11 Mar 2021 14:59:57 +0100
Subject: Re: GSoC IIO project: Mugil
To:     Mugil Raj <dmugil2000@gmail.com>, linux-iio@vger.kernel.org,
        utkarshverma294@gmail.com
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <708e557e-8318-9141-ccab-c564249a7264@metux.net>
Date:   Thu, 11 Mar 2021 14:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sVOsgnyX+X0OPOZKcq4UQw8WoQOlT5qJhFSqGFHSlgj/tVNLREc
 vZkluYDnxD0LGCU0SX9Un786P74iV2DjHTlkI725N9fNEVN/4qJhAx3MyPFsW43ZheXTRE1
 9EfK/Uoczeg0TABVPIpMRFg9IVwOz9nTy2xzZ6nsgQv3gltXVu8b9/i6zbjEmyMGYpT2ESv
 jgkRHbq7IukjWIDiLT6nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K6emM1s/jOg=:V4zzOCj+NhUNGrYM7uz6Cf
 ORhKrN8/8VT4cWGTgQowp9RSC+yknMTfbUEXNOpGAgEIf8v5915Fp821i3915n6Xz8KaF5fMJ
 sOWIiJU52DPbYp+vF9pcrzO+IuEsAw3JHFIyfoApGP1kaiMG4g9neay271epd5RIzExaXSUU5
 SN2yEcGofrMrCV6RYNNnU4WZ/+QeAq/N4RUkvkF49S7JtVcHyUkA0+5y/okYmCg1At4GNs0oQ
 vKyNAbZTjjs75FhRgGsRLP/YvwDxru7cU7MVdHQJ6z3h3DQLV6rv7Qo3BDeEnfVaS7B8o9h01
 O/mZqY2qve1/IEtukNEsBSYarj+YcdCf6EZmaiQBhYCm9W10M/AfRBZOQEK4FjxbxjKmsnf5h
 MiRPhM//cpEck/5HwO31FH2vp2fgVGRCiPvEcLd8yOF/iNKrL3hGg6FW8GhST
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11.03.21 08:01, Mugil Raj wrote:

Hi,

[ CC'ing Utkarsh, who's got a similar question ]

> This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
> GSoC'21 for the project IIO driver. So, I need help from you guys with
> the application process and finding the device to develop a driver.

Since you're not very experienced, I suggest starting with some
simple device like plain ADCs. Several vendors like TI or AD offer
a huge range of ADCs where we no drivers for.

I'd start w/ the simple SPI based devices. It seems they've got quite
some overlap (quite simiar protocols), so parts of that maybe could be
consolidated into some common library code.


For simple ADCs, I've also got yet another(more complex) idea:

Create some 'simple-ADC' subsys, which gives a *simple* API for the
*simple* cases that's bridged to iio and hwmon (maybe even other
subsys's). The idea is getting actual hw drivers for those devices very
simple and small, make them usable in IIO as well as hwmon.

An interesting question here, that needs some deeper thoughs, is the
driver instantiation into the actual subsystems.

For example, if some DT says, there's some "ti,adcXYZABC" on the board,
what does that actually mean for us ? Where (eg. in which subsys) shall
it appear ? Is it an IIO or hwmon device ? Shall that decision even be
made only by DT, or do we rely on some other configuration layer ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
