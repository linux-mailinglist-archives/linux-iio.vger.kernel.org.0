Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53118340916
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCRPmd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 11:42:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhCRPmM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 11:42:12 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4i3d-1lncYI1qo3-011hxK; Thu, 18 Mar 2021 16:42:01 +0100
Subject: ADC subsystem [WAS: GSoC IIO project: Mugil]
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Mugil Raj <dmugil2000@gmail.com>, linux-iio@vger.kernel.org,
        utkarshverma294@gmail.com
References: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
 <708e557e-8318-9141-ccab-c564249a7264@metux.net>
 <9028e023-fd0a-c10d-2d7a-3b4302638c35@metafoo.de>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <1c5e51c3-1643-763a-389e-e50f86bbb3a8@metux.net>
Date:   Thu, 18 Mar 2021 16:42:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <9028e023-fd0a-c10d-2d7a-3b4302638c35@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/qDhfHXuz9eEcaw9AwL6VVHJSRBC3Iycv00Zs/LSW7bqZUU++Qq
 j5WowZJUMfbLpXTE4LIfWomBGIwzbGvXVSchxfjSY5xj8Qvf67IPtcYuk5gmcQWZ9jFbO3k
 N5H08d4rudT/bwm5oqTga4FYSNRuJjSl4xQh+9U2/MAAWtI4vKCa2N69Ki+ok3yWGrcEB5G
 +Wvq8WvLHci+Xy7mq8Rpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKtYX8WFV1Y=:2kPVV+NxKOW4aVtox0T2u6
 1fPvOub9iFbwIFvGNaFi2OABrZx9e7UUS6xMDsXyd1yRkVWma1qq/wpIorr3d0RGtGav+lap1
 rZTNm5V5XW3U9eXht2sSSVM0azdCDf2g8FiMGU5PJQtyklkRuC47bTaCAleYdfonXYbfWyrBl
 SeHKl8AYStHuvzic9OfpBzFNt1TjUg1ZCJqhcjxppvEVU67scIPqPWO3p2VNnQdufAiR2dgg8
 GrlQq1L4VtgRQBl49l+rNxe+5Q2/sk1mHf02EiiX+aHqMjblRuGgCPCd+jllSdbrViUJUVAAl
 se+cPadCMZupZgsdEGr4ba7THGjkC6YJOm+yumVkCRmYsV9VM3iEnsPE6ihIvWleFCjUg1R7h
 HYGgPwNFwT29JGhuLs1+TJ1ufKDUcIakQLmWdZV0Rgq8h4t6iv+HM3m+3aMV6
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11.03.21 16:45, Lars-Peter Clausen wrote:

>> For simple ADCs, I've also got yet another(more complex) idea:
>>
>> Create some 'simple-ADC' subsys, which gives a *simple* API for the
>> *simple* cases that's bridged to iio and hwmon (maybe even other
>> subsys's). The idea is getting actual hw drivers for those devices very
>> simple and small, make them usable in IIO as well as hwmon.
> 
> Not to forget ALSA. Some ADCs are multi-purpose so that they can be used 
> for monitoring, but also audio applications.

Oh, how could I forget that ;-)

> I did propose such a ADC subsystem maybe 10 years ago. The conclusions 
> back then was that we shouldn't create a subsystem for every sensor type 
> and instead use IIO.

I don't think, IIO is a good place here. IIO seems to be kinda catchall
for anything that delivers samples of potentially multiple channels.
That's okay for generic data acquisition, where the OS really can't know
whats behind those IOs right know, and an specific application needs
to take care of that. But it's a bad idea, if the IO has some specific
and fixed purpose, eg. audio input, battery monitoring, etc.

Yes, some of these device classes are already handled by IIO (different
channel types, conversions, ...), but still that needs to be customized
for each use case (the same ADC can be used for many different things),
and often special userland code (eg. in the audio case).

Maybe we need some kind of "policy layer" which tells what some physical
device is used for ...

>> An interesting question here, that needs some deeper thoughs, is the
>> driver instantiation into the actual subsystems.
>>
>> For example, if some DT says, there's some "ti,adcXYZABC" on the board,
>> what does that actually mean for us ? Where (eg. in which subsys) shall
>> it appear ? Is it an IIO or hwmon device ? Shall that decision even be
>> made only by DT, or do we rely on some other configuration layer ?
> 
> Yes, that is a really complicated question. DT is not supposed to 
> describe the software (sub-)systems that are used.

Nore sure, whether that belongs into category "software". Probably a
different one describing the actual use in the greater context of a
complete machine (which might be more than just the mainboard). In the
audio example, it indeed is about hardware, but one that's only
partially reflected in DT.

Maybe should introduce the idea of "composite devices". For DT that
would introduce additional information what that particular ADC is
used for. Could be an extra device_node that describes the audio output,
which just happens to use the ADC as a component:

     audio0 {
         compatible = "composite,simple-audio";
         adc = <&adc1>;
         headphone-detect-gpio = <&gpio77>;
	...
     };

Same could be done w/ other things like battery monitoring, etc.


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
