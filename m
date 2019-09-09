Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949C5AD98D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbfIINAx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 9 Sep 2019 09:00:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIINAw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 09:00:52 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M42zo-1i7JHL3jMG-0007F9; Mon, 09 Sep 2019 15:00:24 +0200
Date:   Mon, 9 Sep 2019 15:00:22 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     =?utf-8?Q?Zbyn=C4=9Bk?= Kocur <zbynek.kocur@fel.cvut.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf04: fix wrong limitation in distance measuring
Message-ID: <20190909130022.chcnvaltoyskw2of@arbad>
References: <20190623122909.hhzskp6k5vm4wify@arbad>
 <20190626192134.4b7aed3c@archlinux>
 <03D5EE82-D6C7-4A03-9404-45B48F1EF5B6@fel.cvut.cz>
 <20190626204936.2756cefd@archlinux>
 <3372AFA8-5AD0-4044-9718-D3E2B76EDFAE@fel.cvut.cz>
 <20190907094632.kalkqtkxlfphdx4w@arbad>
 <7FD0B694-64B5-433D-B451-A0FD4DF32AED@fel.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7FD0B694-64B5-433D-B451-A0FD4DF32AED@fel.cvut.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:bsGjHdMszkx0a4a7YQPoMONJNPW9eYyrTzI1F6uNoMMb+rurgtM
 BJg5R02pO1n1FNgtiAXSWiF7h1jsRwYgEo+vaUeeT7EaNH5Rf1O1/O5WqE3nE90Iyk1E07P
 C2SsFWC+5PVlykKR5xuY/0I+oAwxrsJKt52HGfWOeDqT4caigNRbzxnuhqS50vWkoXEEj4C
 Q5RhLeQ3Ld/SO1M8Hucgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0GlFt8KsmC4=:4+YvFIbJyOi1QLCPD+8b7o
 5VIE0Ke7gNfvCzfb4A2sxIo2TfbKUH3OVzjo0c15zfclDh193qg0lvCj6NJsLu5i/H0Ah+1qc
 fs8ITWnMre4wr0nEVaQVXjO2JkXpmucNzM3Ivf5u+enuANDeGvU1lNTN2ZzFRkbJam6bDQohb
 Cm185FO/kRrCvNlnJnEm9quYNS3U7wsemiVelbNqDL3E/Wd6j7y6/+1Eii1p/5tcaWcLu/xPU
 PWbzrQh38SvTW0tU5nqJjtt4YxLtikYYAcPS8RmUsJ9QK3ffD9WhKslIp8+BK3TU+5yJ5Asan
 +HcyFjUV0fNDRkGwYV7Is8QS6WdfDn76DYTe62A3Be4WFtv8CLZodHS0Qjth0aYl97abQU3dG
 8pRRhzUZMI4TdLsvFDlS7i/covPNVt9Hv5/ZxzlUxlzwW8t9xCMzH33pjd0xGarSSiAZAcPly
 6tBpqH6wuAFXsUwaH9lgqMOTQz/gFq1I0djkn/a8RX5sf+85OEYKKMKo7LMJQ7tHC5xZVjgyb
 9KR5gXiQasmGVLZXrQFPua7yTfP/Tg72Kz6COYro+lV3uh5whIM0H98ulMVevP1k79THqhOmf
 2FiEt4gZBx7Uz0HY1hURceTOYmtey3Vh042bYLph7yb3Qn31aCHo2aJFc/w61W8IOiPFraLux
 PYhs2i5BELqbb6EGhNrMd13oP64w3dFooOPp1fZTGWEUtU9lQ9h7t6VDhloEF0PMtCIYZZw8W
 qeNUKdqaXwzf3IRVrbFdW5m2+5eY+KxpILGtuPWcPDvBhQTf9ns0x2p1uzY4/QpFAxV7nURRh
 TwIvCtY42XzeCO/CKOxT1XTxuUG1w==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Zbyněk,

thanks a lot for testing and sharing your results with us.

> I do not know how to do this in the development of drivers, whether it makes
> sense to put a filter directly into the driver or at least pull the maximum
> distance parameter as a variable?

In this case one should read several times, remove spikes and calculate the
average. This sounds to me as task for the userspace not for the driver.

Regards,

Andreas


Zbyněk Kocur <zbynek.kocur@fel.cvut.cz> schrieb am Mo, 09. Sep 08:53:
> Hi Andreas,
> 
> I'm so sorry for the delay. I was working on another project now, and I wasn't entirely devoted to this. I looked at it at the weekend and the modified code is working. I have only tested OpenWRT in build - r10204-38b22b1, kernel 4.14.125. I do not expect complications on other platforms.
> 
> I tried it on several sensors. I was primarily interested in JSN-SR04T (https://www.makerguides.com/jsn-sr04t-arduino-tutorial/). I have also verified other designs (https://randomnerdtutorials.com/complete-guide-for-ultrasonic-sensor-hc-sr04/).
> 
> It generally works. Relatively accurate for the area up to 2.5 m. However, if the distance is longer, it starts to fizz, depending on the sensor design. It is a property of used HW and its construction.
> 
> I do not know how to do this in the development of drivers, whether it makes sense to put a filter directly into the driver or at least pull the maximum distance parameter as a variable?
> 
> Anyway, the change made works.
> 
> Zbynek
> ---
> email: zbynek.kocur@fel.cvut.cz
> phone: +420 224 354 054
> web: http://www.fel.cvut.cz
> Department of Telecommunications Engineering
> Faculty of Electrical Engineering
> 
> > On 7 Sep 2019, at 11:46, Andreas Klinger <ak@it-klinger.de> wrote:
> > 
> > Hi Zbynek,
> > 
> > do you have any feedback for us?
> > 
> > Thank you,
> > 
> > Andreas
> > 
> > 
> > Zbyněk Kocur <zbynek.kocur@fel.cvut.cz> schrieb am Mi, 26. Jun 21:50:
> >> Thank you, i will write a feedback after testing.
> >> 
> >> 
> >> Zbynek
> >> ---
> >> email: zbynek.kocur@fel.cvut.cz
> >> phone: +420 224 354 054
> >> web: http://www.fel.cvut.cz
> >> Department of Telecommunications Engineering
> >> Faculty of Electrical Engineering
> >> 
> >>> On 26 Jun 2019, at 21:49, Jonathan Cameron <jic23@kernel.org> wrote:
> >>> 
> >>> No rush, it's a clear fix anyway so we can queue this up
> >>> in the rc phase of the next kernel cycle!
> >> 
> > 
> > -- 
> > Andreas Klinger
> > Grabenreith 27
> > 84508 Burgkirchen
> > +49 8623 919966
> > ak@it-klinger.de
> > www.it-klinger.de
> > www.grabenreith.de
> 



-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
