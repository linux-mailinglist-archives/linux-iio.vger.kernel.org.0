Return-Path: <linux-iio+bounces-24533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660CBA717A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E221897513
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D72219A7E;
	Sun, 28 Sep 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5pMhPcv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD8185B67
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759069003; cv=none; b=eW1CIbiZAMlpJCP56nLxTgbfj6sSLR+saBcdc+oxB8yk2pjcgdzK4OtWUHTmbFQdcA7ZyFjPPXx9r4nJ2oRZM4rgo56jaVHgoJpso1gj5YWXvdvdZ/0C0Uy6hpY0c43qGSLAZW/MaN5CtLB/G/rgULuElWS0umtZx5m6hgsorRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759069003; c=relaxed/simple;
	bh=FmwvbHDppjU9CvYc2ySBEPJJrA8QuBJrnaeLbvaNeq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAcqd3VLVplB1OmQcCF7U9DscBaz/kmuSsqR8nsbz9jsGdLgHhkXVjjS7gvoyuxS10h7JQOj4ULF4zlSDvjxjNu+2qqZEA/nEed8u6sQocfLe0QIm3yy4C3w2RkaGVFZx5N91twXhtr05DCFBdfBQnDoyj6UnVIAglBmEtNcijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5pMhPcv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5515eaefceso3608178a12.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759069001; x=1759673801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qS561fu3xGPohq7c2b6s9Kqxn1syIAU/WENOzQp7H2A=;
        b=i5pMhPcv2txHGkH1YtzaqUjxI6TKbfbfQaM+KOuZiwsetEjjnW5EfpJ6ly+tJaWx6F
         Z9kl+Isk82Ajz+rI3D3D1gveiFFbaSgVm/ZwvaMdMzT1k+kXZZMNaExt8IhhrUmm8M9X
         v8vCv81+Njd3cSpNgvAOk94SRWr45YBIPVrNRl+ScVjlLjcc1+jsaYuvOfSVM+E8sydO
         I520epSXPTuWD/Zi96mrxzlxqlyukGF2A+FF/ut2ZHfE3ct8Am5LoMRFcnpOVCkX8nYB
         9xbW3nT4dLTFxGtgfhZSTtgNdZPNRP8GWLNVQADu4gK2A0KWoYHhaWngGxAqVjtaW48+
         7JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759069001; x=1759673801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS561fu3xGPohq7c2b6s9Kqxn1syIAU/WENOzQp7H2A=;
        b=cIBwdIyGom72ECqi0u2ByvqQ+Jo0vs+UzqYZhWUoNommwPOOD3wqf4IKVrzb3Kz25U
         xuKTzjU+yyNTpR8Xj8vJReugYCgSkp99csYEJe/rjevrcfiaNxOnmN8LjROAzotishlf
         jF3ocil+9rOCLqwevJEhJGKoPBu1VUYwoO2bz2WDwzbrROXcGuJo3JOHSSsaaLKpF9mz
         u6R4i2w9YEd/TRKvTcqmYvg/XgvRmIUh5GIk0cExW6XbxJDUiGEMNfdYXqPXQ191bXjS
         F5bNSNwkofRvZF02dHgZoBKndw2AnLmgT5BCWxpZLjMg2n54b7+QZmWhIr33yOibFH6A
         LIOg==
X-Forwarded-Encrypted: i=1; AJvYcCW+oxLJtv0ve0pJyrEEnVGWcaEILB/xep8mLm9C3VcMnryVlxBdm9FhdzdKtTpVa4ruJNtLrQe4yaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2S4Bec0OrlktWyLBKRZAmJ+NEAPz83yF1xUjm1wyloW+kSIb
	0pFrRIOIiKW388RBUBUI//+0Kqug1rwmFpzbkBzQkS8NvY2+OhGLDRgJ
X-Gm-Gg: ASbGncsRnFuJkUm4PRPcZu2/iMucdNOP6YvesMDTrOjjOPOvUi3i++ZwD2RR8gIIv1B
	NYWsxkdxya33/7bZTzkdb6W5AmyEGJdjhArHJKvDf1Y6ct5Ec7chkch2dW2Wi4es63vacMs4T+B
	o9gS01ACe76d2b+qQm7G9473Hm+rj5jlh3HWPkwRR9Yccyqt33aPUd6Bie/0rOIPwtxSfO7X+xc
	8JgRPSOIIdyeb6OCh/LwVTn3twT3m8HIqfAD138Q0f/6k5XdVEXXZ69voB5YtJDyf7f9OOJqh9w
	MrpfzNfI2JdPH/6O7yNJQljmi21ht4if4OXOB3RVOkUmvtfwLixatzg3uIzNi4YvxHg59j6NYkH
	Wu3r21gAhJpVG5J7ajT+L29NjOXJTFa8RRK8N5mcScg==
X-Google-Smtp-Source: AGHT+IGylC8pdXw7Cs1te5retyIezZV7wuMBKjmnFoV675Y5zYlzg5VisBqeLGQ9FgxZdW/sAWmpqQ==
X-Received: by 2002:a17:903:946:b0:271:49f:eaf5 with SMTP id d9443c01a7336-27ed4a30d16mr151724525ad.30.1759069001499;
        Sun, 28 Sep 2025 07:16:41 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6ae5742sm103357305ad.150.2025.09.28.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:16:40 -0700 (PDT)
Date: Sun, 28 Sep 2025 11:17:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v3 4/8] iio: adc: ad4030: Reduce register access transfer
 speed
Message-ID: <aNlDfJvyXjnfINy3@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <fd505d37aceaafd6b20626bfd3f25c47db1fb004.1758916484.git.marcelo.schmitt@analog.com>
 <20250928105316.782d076e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928105316.782d076e@jic23-huawei>

On 09/28, Jonathan Cameron wrote:
> On Fri, 26 Sep 2025 17:39:42 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Configuration register accesses are not considered a critical path in terms
> > of time to complete. Even though register access transfers can run at high
> > speeds, nanosecond completion times are not required as device
> > configuration is usually done step by step from user space. Also, high
> > frequency transfers hinder debug with external tools since they require
> > faster clocked equipment. Reduce register access transfer speed.
> 
> So making debug with external tools easier isn't usually a justification we'd
> make to slow things down by default.
> 
> Is there another reason for this being useful as opposed to not a problem
> to do?   If it had been done this way in the first place I wouldn't have
> minded, but to make a change I'd like either some others to jump in and
> say, yes please do this, or a reason beyond you are using tooling that can't
> cope with 80 MHz and don't want to hack the driver when you need
> to slow it down (my tools can't cope with that rate either!)

Main motivation for this was a suggestion from David.
https://lore.kernel.org/linux-iio/30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com/
By the way, if he agrees with, I'll add a suggested-by tag (if we decide to keep
this patch).

Reasoning a bit more about this, lowering reg access speed may help debug with
external tools, but it won't help debug transfers ran by SPI offload hw because
those transfers will be fast anyway. Maybe a more relevant potential benefit of
lowering transfer speeds would be to make it more "friendly" to slower
controllers. E.g. raspberry pi controller reaches 32 MHz maximum so, unless SPI
core can adapt transfers in those cases, it wouldn't work on a rpi (if anyone
ever connects this to a rpi).

Me, I only have remote access to a setup with adaq4216 connected to a zedboard
so I won't be connecting any external tool for debugging. 

Another thing that came to mind now is we could just not set speed_hz of
spi_transfers. AFAIC, those are not required.

