Return-Path: <linux-iio+bounces-6006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B8B9006CD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C031F22B8C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AE197543;
	Fri,  7 Jun 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKV1tgZ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D9194AC9;
	Fri,  7 Jun 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771151; cv=none; b=oXBA7DMvTO7LsEcbmbo7qlmW926i+yl/VKBDAwmmpgobtwCvqxkTbWnAHntdwZxBOQ5u7DRKiMj5q4yW7fXU+5uQoWqOAkuyiXol1zZzBHSnXPLEuHzCbIeaUaZToC2yAaaX3I/bX65QlqkFWt1NQrUbg4pypBNykSQna65xOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771151; c=relaxed/simple;
	bh=W3wrYHtqo+bJ8K0enZqOAavHpM96oX/oFjtjuQWi+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdCOUwXWlFyLoxh1EsZu52/A0c2yDVGtpaXuslZv7kvy3DfGbfvqj9Dplbx4L4O84RF6GjyPvqeOvI4XSkVg1pcIbOGlPXN67pVMHg7HTUyr2VPJIl9bdOaYo1rfwP7Dsj17j1wxoRpiP5kLdX2a9TmBpNkM2sUBTgVbepmNTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKV1tgZ3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso92463a12.3;
        Fri, 07 Jun 2024 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717771150; x=1718375950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/f/Oi5XluXEWQ1D4hzwtOzeMatJYwD5RcCHoIy1Hvk=;
        b=NKV1tgZ3kwwkKcbhEhgGSLxQUb7TfmoZTdyeE5sog3zktIBnOw4Dj0ifjuglRRneFs
         BFb/e/fNlm50JsnkZWMpEsLMs6490PoQ33YyVR61QAPRhsWfI9SjUbiXnlLUGNyg2k1J
         IpXUYhoqRDi5/lf7tN3KDwiy6szxsb5RdZ3CNLMYu6qHBjB/CEq+aUQ0sXGANhxgtwic
         mfkDk3FkjkhpsEBSCZg1D2f4Hq2pwNwSjkGosmmxL4nPauac+cpaWEuzFKuu8YaeKygM
         2UIDLnShTb4i5rFbFRpp5cf5+HUXjc3PZvWBv/hK9O0vQJc0BliMTQYXJPJJSzEm3nz6
         uPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717771150; x=1718375950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/f/Oi5XluXEWQ1D4hzwtOzeMatJYwD5RcCHoIy1Hvk=;
        b=N3wwe4U4Y5FSSCAS6E5imP3JYqYRc/WiLg/QwHZxboGkmEF4humt+C0xcLWUJOUcXg
         /xA8+SK0nPu7q49thClWUbxOk7kFdVPVG4xtWCxDk7Cr80KHLsoeL/W6ig+yZbpaP5at
         gj5FQKjwMBSBbfqL6tZfnlAW6lFCJ8uB2GPZbQ5Y2+OsO6XGoPs04P984/VH/05sMNVN
         toG8jqu3WgIiZRm9np9VA45N5RkL91Lir23CK9manzHTYsxUYeiVNuxhxvABwFtUsevW
         eYcCtMqGOhdm9qTocbuPr1syXrH2seldWe2G+sVFKWKSOaB0O5AU18ApJDMsVeVe60Tv
         jUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg3cU2DIe2MTXj+cvnipbIy7TqaXp4WHQHR/AnsH+pfTRSrH6zmFZ77p5VZUSQnPWO40ufc7XueY3NVePhEC12W/btTL4f6oLIx9eyCnKHCDyUPwLfpFDMHYzRFF2VtR14mBuY+mQKJTPxD+cdAsX7gJpJ0XOmHjzGuW4bHcZX/KBsl7H/VQtXUenpcq3lNXkhZzP64w7TqwINfu/5zw==
X-Gm-Message-State: AOJu0YxLXi91CfNBU94Pbm93X2TfrdVzyPxLvJWlkj4XIC6wCf4/0Ss3
	4alh41g3o2EjYOgFA/9geBHj8lOtZ+lwyRd4BfKqO+4ZgHH7pFmL
X-Google-Smtp-Source: AGHT+IG0opAjrQ5yl44/E2vjkow+VRkTP/Cu+hf29SVzv/sfXcq1o8LP+aBY8D5Ig61A82XXqIWqRA==
X-Received: by 2002:a17:90a:5b14:b0:2bd:744a:1131 with SMTP id 98e67ed59e1d1-2c2bcc65362mr2705930a91.30.1717771149616;
        Fri, 07 Jun 2024 07:39:09 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806399c5sm5682717a91.9.2024.06.07.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:39:08 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:40:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
Message-ID: <ZmMb10S0ewIwouXJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
 <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
 <0e18b3aa83a62103b0f06ee516193c03f80abae9.camel@gmail.com>
 <f8ce5dc8-ed68-4f04-af3a-187bf0e4a3b3@baylibre.com>
 <ZmIqxS-xUVMNH_lJ@debian-BULLSEYE-live-builder-AMD64>
 <04b1296ff98a0accbf962a4a4bafc2e85a9869ae.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b1296ff98a0accbf962a4a4bafc2e85a9869ae.camel@gmail.com>

On 06/07, Nuno Sá wrote:
> On Thu, 2024-06-06 at 18:31 -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > 
> > 
> > 
> > When is a driver version check needed?
> > Yes, older versions of SPI-Engine won't support this, but the patch set should
> > cause no regression. Even if loading the current ad4000 driver with
> > older SPI-Engine HDL and driver, the ADC driver would get a warn (or error?)
> > and do what's possible without MOSI idle feature (probably only be able to do
> > reg access) or fail probing.
> > 
> 
> Maybe I'm missing something but with the patchset we unconditionally set
> SPI_MOSI_IDLE_HIGH. So if we load an hdl which does not support it things will
> apparently be ok but it won't actually work, right? If I'm right we should have
Yes, that's correct.

> a bit in a RO config_register telling us that the feature is being supported or
> not. That way we only set the mode bit if we do support it...

Ok, understood. Will do it for v4.

Thanks,
Marcelo

> 
> - Nuno Sá
> 
> 

