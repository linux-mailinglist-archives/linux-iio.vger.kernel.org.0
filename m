Return-Path: <linux-iio+bounces-22926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AFB2AC6C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9AD4E44DA
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CB147C9B;
	Mon, 18 Aug 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b="K1IvlgK6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7842B9B9
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529931; cv=none; b=mVGV/WkT+7mdGXpFfRsSSsXS12wkqHXRCSPKAtNdJP+k5sshir1FzSLqda1CzmlaZ0FWJK2CM072XMiV46QM/dNt+fmeV2n8WVnviY07Y/6O6nGkCVamnaPLpduY3kFf+JmQ683UdNQaJe+/O6HlitESyLjwfExnsCEfG42k2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529931; c=relaxed/simple;
	bh=GOINWpV503zhNSh0S7R/fd//+2YoOn40dCvVN4PqxrA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ab8IS2naBr2p0fl8poH8hp0ikCx6B2ryrp4P+cadpDtlITKrmAMjAW8HzvCCc9BngZy1fkogpKjL6Mjoe94uEYWrGffgZdbiYAKWVkhaRqt8+C6SkhMBNnZG4UG9+DVD9MOBFRx9GTRf+Ww22cabJbpmhFDfXsEXNU9gNCGlIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b=K1IvlgK6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109bcceb9so50721521cf.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter.com; s=google; t=1755529929; x=1756134729; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onn0mFbzSZgX6/mRY4JJJAmbYjWdighwL+n/SYc6vis=;
        b=K1IvlgK6EV376mie6OOe/iE3ZObJu67s3c3nCbuA2jrQfc2LOh24bWUyTaw49h9GfT
         2jGUblTrIJrV/W3q3nKmDa3EvLi+v4HDt1q0AJkbxQrcxOrSCr/ZEgcPCWRRHM5Tok5q
         JYPPMW4IaioVRvpnXpTXZdVJKTcLuv/c44A8jo7fG4Wn9/z4CPbYh9QT17AS5e1PH4Ex
         LVkSr12k6cIjSqFTWTUhpmjD+z1XTHBFkhEQUXXUHR1uEaQ1yde/tE95TRH5TYKfknNm
         03qHsRCn9Q59Hs1e8o5m352HhTMnrogsvuQJp1v0RsoupTeTusxdnU4ziLXiUuROcB/2
         DNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529929; x=1756134729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Onn0mFbzSZgX6/mRY4JJJAmbYjWdighwL+n/SYc6vis=;
        b=tDsaWauSBIZZ1cXIXcuc5mMx0j8K30g7irgvhJNFrhjR1A26OUiI4mjbGHay06CktC
         uc0XfWUeWRwj7C28Ud+alWAakQIJAuLxF9XVgpuqmrdHzjrVUlK5D/iazU1rG4vrjY/x
         Ra5WuD7dgESx9XryDYWM9WiBp8EMWGXKBzXeP4nNGc6UA8aWi7+kJNextudoyAMS7crp
         hciBdWlvvSme/sOn1yjTCo2Jau1VCD3Em1qkqbq/9pE7uc3W5gT+s/XCNEU5anaM7k4g
         l22APV5cZ5CFG+cdFtBG9uM52JpK0hR/TvxFa9JqM78pMc0vk/2EJiDhv5m7CU0ZgX9L
         bRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXfrXZg26WAsTsG/Z/mdEPsupZMId4GGivZSqAz87J2BFcEAmU4ZM+L7lnhyMqLOKyiasCkwFJ9VCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBje4rgCyyuWWiWtYVNvWWtH2peVUv8UxhHjQpqBcy2SEIZ3s
	jHPuetMTVLzlUbmQYT8D2K0nL47f9Yr12/lUjKN+hpmuQ9P0iWskktvJWRxmC0jaVnUp5VE7t6q
	J+BmaLBN1
X-Gm-Gg: ASbGncv8bi5FzUrVU1HJ47xu8KI1hPWHWwibV9o8ncr95ScVGKDJdMoTkM+psJi5UOO
	B/hR0fePLC7VmnWb3DewMfAs1usRC2kYj0kehC6aaBpi+dBVCN5BVC75UA3Y7b+UjriQvzEaVsT
	5127xCWfSAhhRLsp42DoTR7rprdrVjF2RxB8p9sO39lgm/f43IUNirHMOGBBFLTxJAhlUaohXVS
	PVh7l6fkhYYYMdeCxQt9uZLu8o1Fn3jmoy8211lMq/pFT0xTWS+zzrdLPcER1ub4p5rUFluKTop
	hTwRRiaSuWP2SVd9S4Td/jESL0duGB8W8ZcLswa8kujhwz9wxza4Gy6cTakHxiMsfhYhWtb3kjb
	Tt22/iZzeEt1P8zqy8V4GXWJIDXkQjvYXGBZmiB7i6RpRbaiCSOOy
X-Google-Smtp-Source: AGHT+IGESdDWGXnHd26as9NY6mAqTBJBwr+tBkUOi+AoCrlKdcJhaufP8wlJwLtxeP0cwINMR5OIQg==
X-Received: by 2002:a05:622a:19a6:b0:4ab:ab85:e54e with SMTP id d75a77b69052e-4b11e0ae8e9mr168672791cf.8.1755529928994;
        Mon, 18 Aug 2025 08:12:08 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de1eaf8sm53354511cf.48.2025.08.18.08.12.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:12:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <20250818150659.GA2948920@ax162>
Date: Mon, 18 Aug 2025 11:11:57 -0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 kernel test robot <lkp@intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81628282-E80B-46BD-851E-6DCC48CCC953@watter.com>
References: <20250815164627.22002-4-bcollins@watter.com>
 <202508161646.PDl6V4EU-lkp@intel.com> <20250816110243.06fbf7fb@jic23-huawei>
 <20250818150659.GA2948920@ax162>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 18, 2025, at 11:06=E2=80=AFAM, Nathan Chancellor =
<nathan@kernel.org> wrote:
>=20
> Hi Jonathan,
>=20
> On Sat, Aug 16, 2025 at 11:02:43AM +0100, Jonathan Cameron wrote:
>> On Sat, 16 Aug 2025 16:46:12 +0800
>> kernel test robot <lkp@intel.com> wrote:
>>=20
>>> Hi Ben,
>>>=20
>>> kernel test robot noticed the following build warnings:
>>>=20
>>> [auto build test WARNING on jic23-iio/togreg]
>>> [also build test WARNING on linus/master v6.17-rc1 next-20250815]
>>> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
>>> And when submitting patch, we suggest to use '--base' as documented =
in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>=20
>>> url:    =
https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio=
-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
>>> base:   =
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>>> patch link:    =
https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
>>> patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for =
mcp9601
>>> config: riscv-randconfig-001-20250816 =
(https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lk=
p@intel.com/config)
>>> compiler: clang version 22.0.0git =
(https://github.com/llvm/llvm-project =
93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
>>> reproduce (this is a W=3D1 build): =
(https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lk=
p@intel.com/reproduce)
>>>=20
>>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/=

>>>=20
>>> All warnings (new ones prefixed by >>):
>=20
> <trim unrelated -Wnull-pointer-arithmetic>
>=20
>>>>> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid =
conversion specifier '\x0a' [-Wformat-invalid-specifier] =20
>>>     440 |                                 "Expected id %02x, but =
device responded with %02\n",
>>>         |                                                            =
                  ~~~^
>>>   include/linux/dev_printk.h:156:62: note: expanded from macro =
'dev_warn'
>>>     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, =
dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>         |                                                            =
         ^~~
>>>   include/linux/dev_printk.h:19:22: note: expanded from macro =
'dev_fmt'
>>>      19 | #define dev_fmt(fmt) fmt
>>>         |                      ^~~
>>>   include/linux/dev_printk.h:110:16: note: expanded from macro =
'dev_printk_index_wrap'
>>>     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);          =
             \
>>>         |                              ^~~
>>>>> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument =
not used by format string [-Wformat-extra-args] =20
>>>     440 |                                 "Expected id %02x, but =
device responded with %02\n",
>>>         |                                 =
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>     441 |                                  chip_info->chip_id, =
dev_id);
>>>         |                                                      ^
>>>   include/linux/dev_printk.h:156:70: note: expanded from macro =
'dev_warn'
>>>     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, =
dev, dev_fmt(fmt), ##__VA_ARGS__)
>>>         |                                                            =
         ~~~     ^
>>>   include/linux/dev_printk.h:110:23: note: expanded from macro =
'dev_printk_index_wrap'
>>>     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);          =
             \
>>>         |                              ~~~    ^
>>>   drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable =
'ret' [-Wunused-variable]
>>>     428 |         int ch_sel, dev_id, ret;
>>>         |                             ^~~
>>>   10 warnings generated.
>>>=20
>>>=20
>>> vim +/x0a +440 drivers/iio/temperature/mcp9600.c
>>>=20
>>>   422=20
>>>   423 static int mcp9600_probe(struct i2c_client *client)
>>>   424 {
>>>   425 const struct mcp_chip_info *chip_info =3D =
i2c_get_match_data(client);
>>=20
>> Probably a false positive as I don't think we can probe without =
something matching and hence
>> that not being NULL but an error check on that match is still a nice =
to have and should
>> resolve this build warning.  Note there is very little chance a =
compiler could ever figure
>> out if this can be NULL or not so it's a reasonable warning!
>=20
> I am not sure I follow if you are referring to the -Wformat warnings
> above. Isn't it pointing out that the second specifier is missing the
> actual type? Shouldn't it be '%02x' or something of the sort?

That actually was the issue and has already been fixed in follow up.

Thanks=

