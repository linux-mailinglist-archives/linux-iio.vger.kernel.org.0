Return-Path: <linux-iio+bounces-17653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E6A7CB34
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57B9177CAF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DDF1A23BB;
	Sat,  5 Apr 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im0xEPSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B82199E94;
	Sat,  5 Apr 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743877515; cv=none; b=b3z65htrNl3dCNGmdaldsJwRia/3xCv6kuE4Z6LoeLqjDRKH9JO9YFZAg6zYpeiokliCLQEXXGwLjfZJrBApWuu2jJKC3hv1wVk2emsULb+T9JwKm4LS7qxbvrFyun3qExFhJbk+PV+Iq9Gt5xN2Croa76LcgMR8mwBdbxQeQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743877515; c=relaxed/simple;
	bh=Kmh0m40Q+BhvO7eXvmH87q7FUqp9NDHftacPbN+IbLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF9iRw2jrdsiOD7NOfUATwWlR4FeG85PhuGZH+mdO/huLycSS+m6x+maEnffrpmX4Acw5RRA4aSntGmrXvZgzvKBBd/zQtd2I8GhHTc+APndPMqZRdDXSs1RUBb872C1VqWZveeMjBup5UXP/+VPXkMg0LvXqWwYiRHPxFzhdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im0xEPSG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73712952e1cso2784675b3a.1;
        Sat, 05 Apr 2025 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743877513; x=1744482313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7ewSWaS2GVG56nYgK2WLjkB3agbziznkvkwItHJZzw=;
        b=im0xEPSGmEFBxvbE8XOOx6aDE4yNAq6C5pIA2e5K6dGa/K7OcbnapO1fgT80fUHwLX
         UyPriJtyhuM8+QTmLfOyfvkB9OwRYNV3qQ4eBCnRK/9OnOMvhcgx5SCPAiOkZuXOUe/5
         +zADmoLcYz9XdNGo0i+U9LgE7BwDB+vqiF/5pSkK7emZsmXVLpkwn1fDZpZeLHsMtvf+
         qO9nbGTPAAUt8C2NwvKe3ZdiUFRX4pXebwaG6K5ZSDOzXBdwGGDj3NlpVxPsT83/+B0b
         Ztyp0RXNrkvlUr1l8NUDg2lPGdZisnxpSgxZ2egPbd6isG/oEKHUt9qyJ+ScdM1NpUGr
         UEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743877513; x=1744482313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ewSWaS2GVG56nYgK2WLjkB3agbziznkvkwItHJZzw=;
        b=TOCoVdTu1pj2zVqSJxLrY2ZxH0hLkW9EvBIvOHOdEwHbH2xXCRyOEDyKvjStaFL1FO
         HnS/JX7/9sVDjJGzipCfhWgcr64cCSO2KeM5Jimi85VetT5zKDxVzKNeeSXVy+Q4ShPy
         iznsgjKuAAjsmpuLRPgvzrGEbGQU0Puxyhmr7Bo42kzlfNoNqqscaPUdN3CKNoxjXMgR
         dC3wGm7+XLUlzcJCPXklqf0VZw+k1NK/pRc/BoktAnt+Sx2di7QDbq2qtttn9vTMslE8
         uQesS1rfDDtBZh2j0wUSPFgsfVIN9YWrwYkCOIS2qVkqezJrMRRRpmwb2t5fVh2bCw/k
         YZug==
X-Forwarded-Encrypted: i=1; AJvYcCXebsoQm3k7yW6ilq6CmlSDlDfRaoRpnLWGDYNAQpUGP697FPxlOvqwAwOsiYL3VP7YWWd2WXUlufA=@vger.kernel.org, AJvYcCXehtWO0puOyrrmsoKdl0eDfjjK2yD4KxsEpoFxEmk1EqTbxFgqbOImcqMNW80ELKwTS9ldFvaMGzvoodrK@vger.kernel.org
X-Gm-Message-State: AOJu0YxraC1hEaUKVcxyJF7VVSRIo24t92SoKHUbBlTf7K0eAahjdHfi
	IM+3b//7+lFDb+znekB4v6cmTn6RYfug7NcQAk3zZqTKYaMZA+v9
X-Gm-Gg: ASbGnctuTZgxBsIu0QR7Ao0jv1QP8B3Ddf6LgfN5FV0cxkYPQYfFFUSfBzsEyeXT1v9
	DK7Vq5CCorXwdoQUoShKKhSJFT7ZGPwVITb0oIKr4iW4urIu6ocsMch4aJpUdxsSvS65tBALxm/
	KM4vkZqxYX1rLdQSj039EFctAV+IHO6YCYXdgcgGTf+Cr1ctmPVnYkmX+6gx/t9QKfglyXw5Z56
	9r2yJBSZdYPiO4yhFsBcIcD3AxT53q7YQ/JsrxoKmKQbB+WlqCkYP82WD+9rIi2Mkb8QSTzaqCj
	zyrLWNx+dCJWaqtRMk+x8FKofBw8XAFGAWJYy2qrGIPgfmHRLbJ0rLE=
X-Google-Smtp-Source: AGHT+IFO1XcsQBOIYFVKaw4dyooP2Io5d1+/q+uwLQDAK9JS5XR9w23ocEXj/CPJYCJ4P5CoT1Pwsg==
X-Received: by 2002:a05:6a21:3942:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-20103fd9495mr11402778637.0.1743877513060;
        Sat, 05 Apr 2025 11:25:13 -0700 (PDT)
Received: from localhost ([2804:30c:1f4f:6800:9245:316f:6226:cc1e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d9ea0a71sm5500382b3a.113.2025.04.05.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 11:25:12 -0700 (PDT)
Date: Sat, 5 Apr 2025 15:26:17 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Saalim Quadri <danascape@gmail.com>
Cc: jic23@kernel.org, dragos.bogdan@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com
Subject: Re: GSoC Proposal 2025
Message-ID: <Z_F1ybM7B3g2WHvx@debian-BULLSEYE-live-builder-AMD64>
References: <20250309161905.4b029278@jic23-huawei>
 <20250405062348.43025-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405062348.43025-1-danascape@gmail.com>

Hi Saalim,

On 04/05, Saalim Quadri wrote:
> Thank you very much for the responses, albeit late, it took me sometime
> I was studying about the working on IIO, and the proposed driver on the GSoC page [1]
> 
> This is my draft proposal: [2]
> I am continuing on the same thread, as you mentioned, to keep it on the public list.
> I have enabled comments, to ease up the review on your end, such that you can identify if any issue is present and point it out.
> 
> My major doubt in the proposal is regarding the timeline of the project.

I've added a proposal template to the IIO project page. The template has a
timeline initial draft. You may check out the template and adapt/extend the
initial timeline from there.

Elaborating a good work plan is probably the hardest part of making a good
proposal and requires students to either study the provided material in the
project page or have some development experience (or both). The work schedule
doesn't need to describe everything in detail, but the more reasonable your plan
to achieve project goals is, the better it may convey you as a good candidate.

I'll review all proposals after they are submitted.

> 
> I also would like to suggest, if we are able to complete our first driver before the evaluation, then we can discuss working on
> a second sensor, if that is alright and if we are able to complete it within the time.

When time and energy allow, the sky is the limit. My estimation, though, is that
developing a driver for one part will be more than enough work for a GSoC.
Still, if you are excited about doing more for IIO, then sure, add that to your
proposal.

> 
> [1]: https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver
> [2]: https://docs.google.com/document/d/18R_ZNWn36mAG9gb2TqepuxBwj-Hck3CrZHFfWUuNmyo/edit?usp=sharing
> 
> Thank you very much,
> 
> Sincerely,
> Saalim Quadri

Regards,
Marcelo

