Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984265F114
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jan 2023 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjAEQ0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Jan 2023 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjAEQ0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2023 11:26:42 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB824C
        for <linux-iio@vger.kernel.org>; Thu,  5 Jan 2023 08:26:41 -0800 (PST)
Date:   Thu, 05 Jan 2023 16:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1672935998; x=1673195198;
        bh=hkx5scIgMzsEcBB5JyGZyNLYzbEu+AwqPA1IFe4L250=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=lukJ3Y+BLMdeQ9SD8RB/ntm8jDeThIyWrggMPVHJfIIyH9A41G6WCclcKJp6uqQdc
         kxk57Jaj19oM4hrBDYrLpyifXpMjjxtAk/1O9TjeSwl1OApOlnEJ08p8WgN+T0oVhv
         HF+hHi/88i1N3Ue9S83Rn0GNaMDgtY70P1m9KzUh9Jp2aUOVk015a1OSZCRT3gQiH1
         /ihI0kueIRKV9FpC/UwnmXQSK5hoSArgmsUei7o/Sn+eLc2coGx/YeVp0wsaKhanY7
         amNMKvj98j3Ctn9ivc48+9VeZy9b93vOrxAccLVg+tfB0uc5IbIPImprJ/GGGa3QQl
         ldB+CzS3u1q2g==
To:     Jonathan.Cameron@Huawei.com, kai.heng.feng@canonical.com
From:   Wahaj <wahajaved@protonmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
In-Reply-To: <20230103112629.000063e8@Huawei.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com> <20230103112629.000063e8@Huawei.com>
Feedback-ID: 13756336:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

------- Original Message -------


On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron <Jonathan.Camero=
n@Huawei.com> wrote:

> On Wed, 28 Dec 2022 14:05:24 +0000
> Wahaj wahajaved@protonmail.com wrote:
>

>> Hi Jonathan
>>
>> Hope you're doing well. I have been using a laptop that comes with a
>> CM32181 Light Sensor and after upgrading to the Linux kernel 6.0+, my
>> laptop cannot seem to suspend because of the PM subsystem error. I
>> have narrowed the problem down to this module and I believe that the
>> commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culprit
>>
>> The following lines were provided from the journalctl logs:
>>
>>
>>> cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
>>> acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPLM3218:00:
>>> PM: failed to suspend async: error -121
>>
>> I would love the chance to be able to work on this given any guidance
>> on where to start
>
>
> Hi Wahaj,
>
> Certainly seems likely that you have identified the right commit.
> As a starting point, resend this email to linux-iio@vger.kernel.org
> and Kai-Heng Feng kai.heng.feng@canonical.com
>
>
> If you could try reverting the commit to be completely sure it is
> the cause that would help avoid any doubt.
> Superficially the only thing that I can see causing this problem is
> a fail of the i2c bus write.
>
> Does the device work prior to suspend? Try cat /sys/bus/iio/iio:device0/*
> and see if you get any errors (may be device1 etc)
>
> If the device wasn't working at all the register writes in probe() should
> have failed so we shouldn't be trying to suspend it.
> It's possible your machine has some unusual power dependencies or
> similar that mean the device is getting powered down before we try to
> suspend it.
>
> Anyhow, better to have this discussion on list as there are many other pe=
ople
> who may have more insight than me or be able to replicate and help debug.
>
> Jonathan
>
>> Best Regards,
>> Wahaj Javed

Hi Jonathan and Kai-Heng Feng,

I am currently using the 5.15 linux kernel for a while now which works perf=
ectly fine.

From what I gather the suspend functionality does work when using an older =
Linux version without the PM i2c bus writes.

The device does work fine prior to and post attempted suspend with no error=
s showing in cat /sys/bus/iio/iio:device0/*
Let me know if there's anything I should start looking into

Best Regards
Wahaj Javed
