Return-Path: <linux-iio+bounces-1836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F514836256
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 12:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CFD1C270D3
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0BB3A8FC;
	Mon, 22 Jan 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="LZL5F5+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B13A8EA
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923731; cv=none; b=l0aKc41dDJtbcp1NddXwkzdgHznQ7Dnd3nhkd5OX0By3sElt9HMo+47zhEq9ZdLN2QbVaqNQULFt69RM7pJu0VqYQACym7p3dhhEyMqkH2e7UUYkSW+nvUdXGDEgN4T4xXX/d2G0iO/0y4g8C9g5KHX30TRrMSwThU6ViWs7Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923731; c=relaxed/simple;
	bh=p8mFBioFSGMpFI4+0O/7h3p0pouf1wuljSCA6Wdtdqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AclxLd7EIfK5vLKbG5WHjyHI5iTVXuz0uG+R9uhMlzxjtxkcWaAzMuBbS0h4Av3QzEd3NQxtOaYTmwn3eu4x6x5Y3n8Weh9Qj7NlkVTBBtIXL9oabS5zpLrO5VYpjl4nMedZCZjpnalVCJUSlfANL8PmhdQnQ+Skk2ADXbWPNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=LZL5F5+Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74dce86f7so6713735ad.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705923729; x=1706528529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOrKcZx9j959hh2gsjvnZOBiSVynu6VguYs2Gb1PKY=;
        b=LZL5F5+QvXPWdw/enW6IvEEtLbPQpRRd0XQU4Phx0UgEsHm82PQ9uyUN1UMuxP7F4u
         bd4vNgXSDg+g6GK/9AYJ0omvwzGvo6RiWbXJjoRbnDIcVsqwboamm9a1vEHUty/OjTnk
         awW1PnzKCZvRB3Qx4yQWObPn7dPMSK2IFwhquoItXiRo1h+ISo0LH3duRthNJahzhgG+
         JK0LJnEYtz+xIYI9cWIYk8bH4rHRP8s3PpiMuvJsgnpWDiS1Kfifl7laZ3IkzlioQisO
         o21ydjj3AhtpEV228HazvPsXSs9+lygNOkd0GnNWMbaPaa85TlIfh7sVCieKxVvSVWEH
         pUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923729; x=1706528529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOrKcZx9j959hh2gsjvnZOBiSVynu6VguYs2Gb1PKY=;
        b=YN0noaxxodXqFQp4oYsC1NI3w7UlffrrRr9/0N93OQyzf6SgmGiLxe5s950V+kMSRK
         enn9VOHhhXiuYOAPuB3H53T9z7JxP4ZL9fBYSRUltIh7tOw+YL9yjFIeojIY3XAmG+1i
         SliV0yHa+oKbXsAVKP0v3umxgq+7lpVpp7cSHtj+kmo19PcAri8ZQbjum5ZkssSMAQlj
         F4lS9a5jgRqxq3HkuvoFQJ/C51zc8I12IF79GpH+F/G1kNnSfmVa0WYVsE3qBUlyTMNV
         bJdwSV42JJmbOnE6xjm1GJHtfN9+sSFclvge+eqxeH/DOgDAQqb6WbVhnToRPfm9glKH
         NDOw==
X-Gm-Message-State: AOJu0YyqMrip+RSb9kUU0n0EPAGELfAmQj8QChjUpJ2fXghGAKTZBd4E
	mwKbg2icmkkStUcEOFs/prVSZY2ka9y5TC87aucpmSRdsoYYuPIfG4TOFSToUbY=
X-Google-Smtp-Source: AGHT+IFhauUxxcHWbRP/G/p+sHBK4ur8LGeSOIoPsyifnQIW/64VbzUo2FKyq+InMqk8yhcKMGyIvw==
X-Received: by 2002:a17:902:a3c7:b0:1d7:1211:afaf with SMTP id q7-20020a170902a3c700b001d71211afafmr3996722plb.138.1705923729229;
        Mon, 22 Jan 2024 03:42:09 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902694800b001d46274b533sm7035450plt.138.2024.01.22.03.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:42:08 -0800 (PST)
Message-ID: <3be58246-1a39-45f9-981f-7ada71868a4b@tweaklogic.com>
Date: Mon, 22 Jan 2024 22:12:00 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: anshulusr@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
 matt@ranostay.sg, mazziesaccount@gmail.com, robh+dt@kernel.org,
 stefan.windfeldt-prytz@axis.com
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
 <Za0TpiKjDD27Vh_x@smile.fi.intel.com>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <Za0TpiKjDD27Vh_x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/1/24 23:22, Andy Shevchenko wrote:
> On Sun, Jan 21, 2024 at 10:22:50AM +0100, Christophe JAILLET wrote:

> Seems like entire conditional here is not needed as it's implied in the max().
> And max() should take both signed or unsigned types, different types might have
> a side effect.
Ok, understood.
> 
>>> +	/*
>>> +	 * Whichever is greater - integration time period or
>>> +	 * sampling period.
>>> +	 */
>>> +	delay = max(intg_time,
>>> +		    apds9306_repeat_rate_period[repeat_rate_idx]);
> 
Thanks for the review.

Regards,
Subhajit Ghosh

