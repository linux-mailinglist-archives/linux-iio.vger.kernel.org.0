Return-Path: <linux-iio+bounces-640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416B805992
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0A61F21766
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031663DF1;
	Tue,  5 Dec 2023 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzFuhvk+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A418D;
	Tue,  5 Dec 2023 08:12:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso25493601fa.1;
        Tue, 05 Dec 2023 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701792741; x=1702397541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oezG7B8/HBZJztf0xXD9ra4YKdN/gDOchCXNN5JSFq8=;
        b=NzFuhvk+WKJnutOVFHFT9+H498k4umcFVehNOtyFT/lhZHG/7TtOYOq8rsJaelqfYB
         gazvdR1HuQPvrgNUVUijNqzS7UqYGqr6RzYGzOd2ZP0H5N2x0zvfAYnuAZVS2tKoAM4j
         QVuZDZGmzu8wFo0XVhZkhZ6/tJnjk8zZkowaEHYYiAVbRbHagVGWP8Z6NvjjZHWktKuh
         b+ra9u3C22Fv11F7+pMwQ7P9JY56DEurG+QKp58uhk2rCHqK4NbU+w8SFeNvts1OyMD/
         vVm7Oudc8+e0P1gu84UUYFkUHRLHAgV09m/utgopdJPOVcQPi/Y2EuIPpmloiEeimfrB
         t7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792741; x=1702397541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oezG7B8/HBZJztf0xXD9ra4YKdN/gDOchCXNN5JSFq8=;
        b=jvR7gKzcWJxACpw+OLaU2nAEdoV1jVHqQokfcfJc1KUTDy7qT8QZmaKK5GMgSqyPN0
         BTHRxPMVtYXkHK3VV441ksM6gKA4BgMRHDoO68y5ur4pbtCmjFAPPGjhYuMqaQzhPy+U
         CqbwQxhomFPvmXn5kSZfDsfJ/gGP2VGC7InyeP5ilL8R3sUxqod4visSLtilnduLwxav
         BsAV/TYx0ZMkcPqRxZq2vrCFKXqnh5URdG1ywOzWx8gKH3pd36s9jlISWoWoW6QTRc+P
         Z6JLSvENjNpcFMG7FVNPLXnc/ld31T2ZJ7tIW+jDjxnQ5ob0KPnzblZlWzFyf+8wyDoI
         PyvQ==
X-Gm-Message-State: AOJu0Yw7gV2DCk5aEs+P1CxEM7+9gVfDFUCQrSTSXYL3hayMUeuxTzd/
	KBTA2uaAqNkwjkUh41X9wHQ=
X-Google-Smtp-Source: AGHT+IE+E63/vH1+CDZdYaMKf9tMjr/DP8SgkKAVZfgkjMkBsNNqjOC6VpIyjWm6X65QSEGY45uloQ==
X-Received: by 2002:a2e:9782:0:b0:2c9:f1c6:e20d with SMTP id y2-20020a2e9782000000b002c9f1c6e20dmr2119970lji.49.1701792741330;
        Tue, 05 Dec 2023 08:12:21 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id gv11-20020a170906f10b00b009de11bcbbcasm6982621ejb.175.2023.12.05.08.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:12:20 -0800 (PST)
Message-ID: <e72085fd-3203-4166-afab-73707d27d174@gmail.com>
Date: Tue, 5 Dec 2023 18:12:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
 <20231205134223.17335-2-mitrutzceclan@gmail.com>
 <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/23 17:28, Andy Shevchenko wrote:
>> +               ref_label = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
>> +
>> +               fwnode_property_read_string(child, "adi,reference-select",
>> +                                           &ref_label);
>> +               ref_sel = match_string(ad7173_ref_sel_str,
>> +                                      ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
>> +               if (ref_sel < 0) {
> Can we use fwnode_property_match_property_string()?

fwnode_property_match_string() searches a given string in a device-tree
string array and returns the index. I do not think that this function
fits here as the DT attribute is a single string.

