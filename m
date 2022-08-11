Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3205907E9
	for <lists+linux-iio@lfdr.de>; Thu, 11 Aug 2022 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiHKVLp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Aug 2022 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKVLo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Aug 2022 17:11:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B199927F
        for <linux-iio@vger.kernel.org>; Thu, 11 Aug 2022 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660252266;
        bh=qrTmAqFsiEs3Ey3cansToTSamk9I7NnWHNHUSdbM4RM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ffKsLKVItvagFIyb4fskEBMrKA3aVoKuwmlxnfXQlLYn9bpH4sG9DrZCNH8tmm/SX
         QT2v0W/aSdN8QqXf5lcRjCI2GaHj8Q3SdEhvrdmLY+7NXLknWYot5Ypqza3kf66qve
         y6X3c7zRIBczsh9yBObNEC+sL5nanksoZLtfGQac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [93.238.92.22] ([93.238.92.22]) by web-mail.gmx.net
 (3c-app-gmx-bs58.server.lan [172.19.170.142]) (via HTTP); Thu, 11 Aug 2022
 23:11:06 +0200
MIME-Version: 1.0
Message-ID: <trinity-f4c7c224-e838-4b7b-8e92-39b9067158ac-1660252266510@3c-app-gmx-bs58>
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Even Xu <even.xu@intel.com>, linux-iio@vger.kernel.org
Subject: Aw: Re: PROBLEM: Some intel-ish/hid-sensor-hub IIO devices always
 report 0 on synchronous read
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 Aug 2022 23:11:06 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f3c95d3355d84562e37252a7313ba183eb219b53.camel@linux.intel.com>
References: <trinity-22d7d0e8-17b9-4b9b-a299-702c061ce8b8-1660243419946@3c-app-gmx-bs58>
 <f3c95d3355d84562e37252a7313ba183eb219b53.camel@linux.intel.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:mLLWgbESN6vzN/iOOeTvhQ1jQ5Nf42wDNAOS6z5IFqKy4hJTXtmpIHT8L2Z/UJKEGleS2
 hdhe7ZAjXFvAkH/yOevmwCRGGgoGVI2ntsVFLOV38tjeTr4BKVGXzxStNZNGZEeJDTVrDNKEimXu
 7pMwDHqUnhTQFLNYNlIELMg2G9NddHMoHs9WVJ3Mvfh+xJbPByMknIpKuYG0rS/bz2kP1IdeuCf9
 UqaL6+g8IEHRfE7feA92GpNi3+e6YrFEoimejAIah7zv1nsUxo4N8a0du+vDMvZ86JVpRVnriTCo
 OQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:G4ckqpVKjN8=:qUzdJ0dEoFwjadDuIx0jsp
 ZqrdfIX/zL0wEtXnLUvv6oxwdJby3DVi4hYANxF8sIFktxwQk8gQL+//za0g2Y+yYiyxWOfu1
 t9ujhO8RDCeahZNIaDKLiuIzRl17U46UiGqJ/ZhCo1TLPs/xPT3MkG/NO7UZ/pcEyj3D9XUGX
 ouQXS7JmaYK+L9cGgxQ1JU6mLAQbYw2ImusmaXppLB0j97KqvaOGgB2pTDE2HfZSvJzha+S+E
 NI1+Ys/jj2jEHm7TNHLz/gMAosayj7tDbzjTz9KYwnh0/4A7wahinhQqajvaAtoJehKJC5oiH
 1PK4HNSFtHsRTCfAchGiuZwLpF3a+idFtVbrf0K5YJCep/xoQ/qQNlxCQhNYrclxBlKvVghlP
 7OhnReKgWg0Js5IheWZ1s9gAggiTNInQiH7JshFE8WHziCCSpR8FNIBH1G9xErqMRnKxhEec7
 PBNsuYv0OaCaQJrG5Eb4iawI9beaH37jUTMOPnzVIuUupfiWNNAso432bbvOqLq2LT4OG/DX0
 FTbOTIFu1BnVCvTTBUZSNfyXBnLxXfvJCttTTODAKmt2kxa5ABXZquH97iikIQ/m2LZNjp81j
 K1wGJjuSHabAWso26fSbaALvSy4tgXRekoifdC5PrAXkz1+rIffHVcm6+3tC1L1oOndhRpqGV
 JljQedAODDSQD8/I8+OWWmhMCZPs1+ITdwbJTHAoAitTFGiY2E9R9LjoyVlUGw2CQuNZUrzf1
 FGETOvUBUnOhC1NnXCRpiDysTf2anctZj32T9APpF4Alv3EZ+tyorMnN7ywr8M/H6Ur4xhCaT
 vczyE1X
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > Some intel-ish/hid-sensor-hub IIO devices always report 0 on
> > synchronous read
>
> Try this:
>
> /sys/bus/platform/device/HID-SENSOR-2000e1.*
>
> cd power
>
> echo on > control
>
>
> Thanks,
> Srinivas

# For the HPD
$ cat input-{6,7,8,9,a,b}-*/*-{value,name} power/*

File: input-6-200544/input-6-200544-value
0

File: input-7-200545/input-7-200545-value
0

File: input-8-200546/input-8-200546-value
0

File: input-9-200547/input-9-200547-value
0

File: input-a-200548/input-a-200548-value
0

File: input-b-200549/input-b-200549-value
0

File: input-6-200544/input-6-200544-name
data-field-custom-value_1

File: input-7-200545/input-7-200545-name
data-field-custom-value_2

File: input-8-200546/input-8-200546-name
data-field-custom-value_3

File: input-9-200547/input-9-200547-name
data-field-custom-value_4

File: input-a-200548/input-a-200548-name
data-field-custom-value_5

File: input-b-200549/input-b-200549-name
data-field-custom-value_6

File: power/autosuspend_delay_ms   <EMPTY>

File: power/control
on

File: power/runtime_active_time
0

File: power/runtime_status
unsupported

File: power/runtime_suspended_time
0


# For an IIO
$ cat header-filename power/* in_*_raw
File: power/autosuspend_delay_ms   <EMPTY>

File: power/control
on

File: power/runtime_active_time
0

File: power/runtime_status
unsupported

File: power/runtime_suspended_time
0

File: in_illuminance_raw
0

File: in_intensity_both_raw
0

