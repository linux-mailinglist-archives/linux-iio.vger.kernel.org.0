Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAEA57903B
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 03:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiGSB5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 21:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiGSB5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 21:57:18 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928E27B17
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1658195829; bh=fcAEnPEEdByRtJnZu/YFOrMfDdydrl0Hv/H+tAFHpEg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d0adqdIdn7SjkIvHyVuiQC25MRx0eBeM6yFJXHa0ffXr/Ct5ndjvQyoAiZZm4PulpXpxuRpmr2nsKQqOClTuQ9FDG0VmzEXf0BKOjjKL27fTpmChV4X/vDWyhElFhSINh4lA7/+YCcjnPYdwYJ7OgvlDRjKtAGJl5X/4PivnbpKHWzkX+D8dsX5qe53lN7RGo0SXE4n0y4qMOldzDX/zY/klH+qHZtrM1A25JttYYnRkp5hY0Q7TZvicVv/pYeXkxJj2x6hfaJ1Q2CLH3dZuull8Zn881zaHoZ4aSgypY+8XFZxDYLGe5CoZlhfS052uI+cZSN9jYOLbgbBr7ncssw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1658195829; bh=DxcsZcsMGwNHbV8msfqvBuhYgtaOfKyqRwMl5Lxp3LF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lp7E9+B+gop8KmdSeUajJK4xxUWIDRLyIshVfl5YsEyiJehwIjZTusVwaQ1noBKoi3Z8GY2iJ4CGEO232S4W/kBRF5l8UcR3z2ThlDl2/vPbrqB5qV8zLt6F051I81kIaWL/y5eD4kTfx0l5kRoBDCx0RKp3NCGHfZ3OV925gSOI3IduYJJCBD0zMx0DTzqz2jrzTkRhloaZl+fC36qvYJrjAJZZj2HW6DkpEqzY4EdkVI7gcVFCvxM/VeXMboEnLpKni5ob1sv8wBMTk1KsFdGtN9hAw/yE0avX6pI6KWJbF4ID2O/ZgPSEzs5sWys4AmAay34cfg/ZL9m0lGXVag==
X-YMail-OSG: pvPjeqgVM1mIv2Ar6ffP8zpn7peFpeYH7DsxR9O_Wu1eqsu8IWnrgQLQCiKwFrd
 7V6cSdY.Hk8Qo_revJDZ0A4Nfh_x_xZt6DqikxKVisCQ3MIfNvITIG9mliOmJF.ceoOW4ySgXxqm
 m_1aAsj7s1CdneBNubh4G9u54LUqrTrE6if9fjiHFqep4C6JX3o4kyRNHNykI16_ZURtPKD.1AXS
 KQ0abyvFCBat7SLwgZqm.9HDXQAaozDDx03t0PzFWWBgceqyq9quR8YIiLHoggVbpHw3ymHkbvtR
 NMtuUBc0YpCQQSlRGgs3KhvTZZ.1wKIs9wshSVEZybKjyAN8cnrP7qCHuaTfumuFEHIpSiGZgDw6
 .IPngU1wEXEn4wmaKAmi.AA8Y7P4SVPXKp.jykGAUTWSI4W1U8Hkdcn_R0pjK7EpPRipVQvKD4Mq
 _XCj2ENNJ398A3ztPaTs4WS1ZTM2cDQ3B8b4RlYCuMbYB0xHhFcLLnDZVgj_dAHfzLJ0S1D4KmXD
 8AQ2LfZ4eVsfyHoN0o0s99QbFH_sYcOa3YDJkeH4Q7BOUr9qle428iP_hb60vA2yiY_UNJsn67Qi
 YxqdUnP_blxhri1xpAC.62mFYxjN7OM1VBKVxMBjMGYhCOdViXTr.FDe.vj4okMx_QKiev_2HrC7
 UmGe2DmX8ajFbgm79CeUsN65nlKJsUzWpU.RsJdU0Zh.WzAnqnJGOLQ6oN7z0_yMbOigDKdgEvoO
 oHjqv3Btq5aRWRDO5HstuXAMXraE78OeJsI60el49Q2y2mILR5nZZUsFUGohjXTtgPsH4c.q5Q2h
 .wl_bpwPxZqAPI_tcckaP4JM6__oZZLeLgHT.jh2ytbWc9R3ssWDNIW9QqQ3FZ0ctc6ULsF2xBjC
 xRXkMg4duIIF2GmIXxgIjnNm9Dz1E4fun90ymArp9NnVRGVSFsttRDMD3U5xWb8PFZPje32iWJnZ
 Yfm5KwdsfVGE4phcSfec_PV71YwB3OTl4ihhzv.o8mf1hmt9rVCL4FGPOv5pBUZPFYK0jqK9r_Fn
 oBWrLgMW1AgPzb0DxlueDZnLWcsKa.jGgB52fCabzGpxKMu0_rryN58aL65asQ1_BSCDWvweEuL5
 lp1Wzaxf0QvZHUDV4d5jkP1z2TYm.5alJrNJRkkkgUUC0ZhR3cBZVyGOCZnC9NgRaTHDIiYF1pEZ
 qgEcYpja3WSslpNfDE_2B9saQk_ihC7gnFCub19bIGKeHbGwW9uauM1997G0J0YOIsFX_yXas4WH
 LVlGZVvNNmTVBrCBJv_WvuBEdD31v35CqMc7cKCGXxGPnDY4H4dmqddZRlcCAi44Cr.IWuMCy8wV
 ccTBDSlgqKp_p18g0WQqRjBEAqsI2jx6fT8YAHLztCW.vayCTo4VMaJo.WMOjXFlubKLKWfjg0dG
 0zJFLk.cYLbof2YAfyghNWReUIHAjJ5_Io7Q_5WWoJ.dFmPPbPDAHXXIT5MT0ErU5uLrfF8WZgj9
 iI9CUs_Sm16byIw7gsxYv36UBleg6aofNsTw_M097so5heW2iOtIXJtKblaLwzdAaZFnikI2l3MT
 P9DEGfKkvlfTyUWmgrGwxs_my.Uy4uPZVv_5Y4evuM4UVNDKEhQtfI9XdEWaW6rh_QoxnslA8Hxv
 dpMAVa8gtgsp2K6l.PhBSU3vEqzr9i12rxjXR8zqHOhC4sIDq6JViAjL7d_YGMtpKgrtbv2wHlX6
 iviMKGGKP0b9_jKeNls3Esii8ZaAe5AmIkeTfjxGaoaXUJtrHQCech7J1bbhpx.jzLGI5Yci2fzu
 vB.7irl166xs4xv7bqfO.7sJHZ909i6znxCjDgURFi7dBpMJUG7fGk.HsOONd6G20sHLKmQPuOQ7
 HxwnMf6f7RmRfeslGL55dyEoNUSYisyz0bK4g8Cp0C.P50rhZXHNBA9AKvp.1KSJD8VYBaiFr0g2
 VNBC1Bj4VyamFMjqX9eWwEhf5mp5THNpUqAHmHVHvaNfBj3CJhmeRBXWdAF_qmA.H8hcodAVWY1n
 .3qwu_vLdwD4MFlKMPixTFIApXmCVxMVt5DF3F2Ci5etTe4c3MS1QdR0v_RBxCbVzgl7ZeF4GlBl
 JY2YYKCKYiuywjCT818z0tu4hQaS81IWZDpOMhYHfydDiUDUF2zxB9r2H2XbEvEYQfclVJLaNr9M
 gBoQg9K8nEtrxaAj1Waoz1voAfHxnelUdAJ3tLECfL6QMwfCt0ll5pmKazHiNKckSuNZESNkzy0L
 605UncycPnA0KVsLTT4GkQn.q7k1sjztgykXmEKuqiG0JOkoIUNhp2hVGVJ6HB4LjwqKDyaRZ9Ek
 EgGpm3VjIdNw-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 19 Jul 2022 01:57:09 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-9p54l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8105bfb90900c2aea1673e887fd8f06d;
          Tue, 19 Jul 2022 01:57:07 +0000 (UTC)
Message-ID: <8af65fb4-79f0-e768-f224-514926e9f77c@rocketmail.com>
Date:   Tue, 19 Jul 2022 03:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, wpsmith@google.com, linux-iio@vger.kernel.org
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei>
 <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
 <534cde0d461b194e2fa9a91bd987da1cd2aae58a.camel@linux.intel.com>
 <CAPUE2usnMyDN5DpgY_dtj73Jb811-9Y6Q8ZLsnqKiA7=q=74UQ@mail.gmail.com>
 <60f39446-a764-2f7f-ec6c-30f49ada3f07@redhat.com>
 <CAPUE2uv-GS2ZMhmzmLzHhUGyrtDJ0GVvk17JafnMSSYdnK8z0g@mail.gmail.com>
 <b0b9beb8440ca40e6673b1ee8473708516d639cb.camel@hadess.net>
 <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <c5fda5ad-59fb-c933-c640-4b3e44ec95ca@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans,

On 28.06.22 14:33, Hans de Goede wrote:
> Hi,
> 
> On 6/27/22 11:55, Bastien Nocera wrote:
...
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1838
>> An implementor might consider that for a hand-held device, a
>> 'natural' orientation would be 'front facing camera at the top'.
>> The main hardware reference frame could then be described as :
>> * Y is in the plane of the screen and is positive towards the
>>   top of the screen ;
>> * X is in the plane of the screen, perpendicular to Y axis, and
>>   positive towards the right hand side of the screen ;
>> * Z is perpendicular to the screen plane and positive out of the
>>   screen.
> 
> Note though that this does not clearly define what
> e.g. "positive towards the top of the screen" means if
> you look at the axis illustrations in both the Windows,
> Android and W3C docs they all have an arrow pointing
> towards the top of the screen for the Y axis, which
> matches the "positive towards the top of the screen"
> wording.

The above actually just defines the general coordinate system of a
hand-held device. Similar to e.g. [1].

[1]
https://source.android.com/devices/sensors/sensor-types#sensor_axis_definition

> Yet Android / W3C expect a positive reading when
> the G force vector is pointing down. Which I still
> find confusing.

In the Android docs in link [2], the third example description states:

"When the device lies flat on a table, the acceleration value along z is
+9.81 alo, which corresponds to the acceleration of the device (0 m/s^2)
minus the force of gravity (-9.81 m/s^2)."

So it is 0 - (-9.81) = +9.81. Confusing indeed. I think this is what you
called "force countering gravity". More on this further below.

[2] https://source.android.com/devices/sensors/sensor-types#accelerometer

> This means that we to add a text similar to the Windows
> docs here, say something like (made up by me not copy
> pasted from Windows docs):
> 
> "The Z-axis reading will be -1G when a device is laying
> flat on a table with its display facing up"
> 
> To fix the are we measuring gravity or force countering
> gravity confusion.

As far as I can see, Windows distinguishes between "standard
accelerometer", "linear accelerometer" and "gravity accelerometer".
Links [3] and [4] are from the accelerometer sample, link [5] is from
the API. The general description [6] is not very clear on this.

[3]
https://github.com/Microsoft/Windows-universal-samples/tree/main/Samples/Accelerometer#accelerometer-sample
[4]
https://github.com/microsoft/Windows-universal-samples/blob/win10-2004/Samples/Accelerometer/cpp/Scenario0_Choose.xaml.cpp#L40-L47
[5]
https://docs.microsoft.com/en-us/uwp/api/windows.devices.sensors.accelerometerreadingtype?view=winrt-22621#fields
[6]
https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensors#accelerometer

W3C also has such differentiation called "Accelerometer",
"LinearAccelerationSensor" and "GravitySensor", see e.g. link [7]
chapter 6. A further link [8] indicates that the subtypes "are most
likely fusion sensors".

[7] https://w3c.github.io/accelerometer/#contents
[8] https://www.w3.org/TR/motion-sensors/#gravity-and-linear-acceleration

That doesn't explain much yet. I'm just raising the topic of different
purposes. It looks to me like at a device on a table with screen up, -1G
is the gravity vector and +1G is the acceleration acting on the device.
So according to that, we're measuring the gravity vector. That's fine
for auto-rotating the display.

What does this means for dynamic acceleration measurement? In the above
link [2] about Android accelerometer, there are four example
descriptions. Let's take our case with the device on the table, screen
up, measuring -1G. For the first example, free fall, we would need to
accelerate positively to get 0G. The fourth example, accelerating into
the sky, this would mean a negative acceleration in our case, getting
closer to -2G. Accordingly, in the second example, pushing the device
"on its left side toward the right", we would get a negative x acceleration.

I'm not fully sure I got this right, I don't have any practical
experience with accelerometers. Though from the last paragraph, it looks
to me that dynamic acceleration measurement return inverted values.
Maybe someone would need to confirm this, though it's not easy to take
measurements on a device being accelerated dynamically.

The Windows documentation in the above link [6] is not very clear about
this. It says "[...] Accelerometer sensor measures G-force values along
the X, Y, and Z axes of the device [...]". This sounds rather unspecific
to me. I don't really know what it does in the end. However, if they
mean "g-force" literally, it's the inverse reaction of acceleration [9].
Also it looks to me that Windows is not measuring acceleration in m/s^2
but "g-force" in "g", according to the sentence "Note that the
gravitational vector should normalize to 1 for a stationary device" in
the above link [6].

[9] https://en.wikipedia.org/wiki/G-force

My intention of writing these lines here is not to change the current
implementation but rather to get a clearer picture of what we're
actually measuring, thus helping to improve the documentation.
Summarizing it looks to me that statically we're measuring the gravity
vector and dynamically the centrifugal acceleration.

Although for gravity, within IIO subsystem there is another interface
called "in_gravity_" [10].

[10]
https://github.com/torvalds/linux/blob/v5.18/Documentation/ABI/testing/sysfs-bus-iio#L236-L244

> Jonathan, shall I submit a patch to add this, maybe with
> some extra text that we are following the Windows/HID
> convention and that Android/W3C do things differently?

The following file [11] would need to be adapted accordingly.

[11]
https://github.com/torvalds/linux/blob/v5.18/Documentation/devicetree/bindings/iio/mount-matrix.txt#L49-L91

Kind regards,
Jakob
