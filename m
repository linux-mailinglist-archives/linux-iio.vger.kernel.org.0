Return-Path: <linux-iio+bounces-12151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794459C459A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1A2B2F941
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233C1ABEC2;
	Mon, 11 Nov 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYIY0HeQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EF1ABEA1;
	Mon, 11 Nov 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350934; cv=none; b=q9oaWrMVFLmOasdAXd9TWnHiAJQOgNKNmWWDaix3cU5lUNV2e8dzycimgSBcaEFtUwhB+qA+FoNGgVcJcUtB0TQe1DEAFpWIXRFDnwOnWXLxXC7YIm6jedF5D3NMZHnU3tqFabbIz869V6ws8TPoyztMdTZ9MZNWUH6uxJOlkC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350934; c=relaxed/simple;
	bh=JMOvddGlVUUn5PbEfdRyr/Yb4oKvX/AtszQtlSEx+H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6TXuvYBBCGiToT2/yv/KmlxT+txqVdfoFPsRiNZXlbcOJwX3DFHVVl4g/yaPI/YpJYh9MvSlNXFIZJPQ3bf82LSiZcLWcKdBHI5joJRPd793kC4T0wgP0MV758HjZpCecw30oVMB27RaqJ4kKgMqXVE0X91cY+AyTRkLoZaeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYIY0HeQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so5888128a12.3;
        Mon, 11 Nov 2024 10:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350931; x=1731955731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XdHTI/HJZSh8vbEXy77DENjUEe/9jP9nGPccb1xD5I=;
        b=bYIY0HeQSV5TQ5BB8mnNQYd8iduwJYJMZsbgvPRGtcr7NLCbnezYllGwb4stWnh2kN
         L3aUKT1n7X1NIcDms3f5ya7veJ5ibV7fm36Q/rKKZdiAv0Bh7edSDKkq/9UUZuxoTlSv
         hKI/BxtyVNYNFwdjHzkEV8ELOjQoucyE81pZLiWQtd98H1E8xRgPafltW0MYq5tbOReN
         mfSgB0YAmO6byb8vREyCKzU8T9Fh59W+DJ+QBdq41T/mBMofMVCCG9PKDHsf4UDjzJ/+
         7RPf2kQ0xF8ytfWJXemDKvOl9tDArsLX9m4MRhF1hdf+3rfF1ldZrhFexOXiOMHeOy0r
         tAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350931; x=1731955731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XdHTI/HJZSh8vbEXy77DENjUEe/9jP9nGPccb1xD5I=;
        b=nQubZdPK9NiZgeA1RYbqfJrEtuB/6tNiAdx52dtSglC/AsMw+ShhZnmUAbGlYbvOQ+
         2vofzuGOZyi5mS9Ayjz/KIvmdXvaOak/3AXrZ2+Kyg7ho6gcCaZHqI3VSElYvzkiLg/B
         KSuhSUk9eP4oGDfIZ6NaT8ZAlhXHFmSxalLRkOgMYSLQEPtJzva6Dmpf9kEMoH94p/nS
         l1gQmgHEZ1eChbE2+Y3b1UmYzsYTpEyLMpOAacbVdwROE2dKAh2fffnn++U0QnqJKmKh
         DYuWpY4tB8+lEMfAUCyekRAVFg5nC4pk7XhrLm1q6DrtUlsHLJ9wO2hff/VYgxsHu1gJ
         /CJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOST3Qulhw6k8qN0za/nXaAPXd+mLO89RD17MhkvphO1y9XjZREzixHRnGaEayyXYgrumw1d7utVpp@vger.kernel.org, AJvYcCV3MFX2guA1wtDgXk3w0soIEJGt62d/W5c6Y8cWF1v6nxLhWqGhc21bjgac25o1DqEU9o47DtxqQyp/@vger.kernel.org, AJvYcCXtf/xl8+PtdxlCFp/SQcyf1ki3YTO8gmQs3X4f+lQ5ZSdZEZ6digrEgyRqJ+dlBkfHOBPDCUg1rRSb45ZH@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6GdSoepVpU7pJUcY+HD2IUx1VF5anTnH1dU6OrgfS42Q+gB9
	yhX3bV/pgFFn/wjYk67FbytIunMlbcKZec0lGU5Vr3LB8JQQixF5
X-Google-Smtp-Source: AGHT+IGWP7F7ndgMCLdojMgtv9NaG/u0qq46mQOTfnF0NbVu2NGu/6E9mZTsbfy7GNEPfnbFt7krYQ==
X-Received: by 2002:a17:907:60c8:b0:a9a:46:83ee with SMTP id a640c23a62f3a-a9eefff1531mr1240286266b.48.1731350931162;
        Mon, 11 Nov 2024 10:48:51 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:6ce0:6054:c068:6bfe])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c3f5sm627341466b.76.2024.11.11.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:48:50 -0800 (PST)
Date: Mon, 11 Nov 2024 19:48:48 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
	gustavograzs@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply
 properties
Message-ID: <ZzJRkCJcbCFSMcat@vamoirid-laptop>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
 <20241102131311.36210-6-vassilisamir@gmail.com>
 <20241102153315.2175fd5b@jic23-huawei>
 <6sucdv4k5jdovqgtaemeer4cnluvnl3xgyn57mo3elgwdmojrx@phu4gowaqtuv>
 <20241104161033.GA228709-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104161033.GA228709-robh@kernel.org>

On Mon, Nov 04, 2024 at 10:10:33AM -0600, Rob Herring wrote:
> On Sun, Nov 03, 2024 at 10:46:46AM +0100, Krzysztof Kozlowski wrote:
> > On Sat, Nov 02, 2024 at 03:33:15PM +0000, Jonathan Cameron wrote:
> > > On Sat,  2 Nov 2024 14:13:09 +0100
> > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > 
> > > > Extend dt-binding for BME680 gas sensor device. The device incorporates
> > > > as well temperature, pressure and relative humidity sensors.
> > > This description should make it clear it is moving from trivial-devices.yaml
> > > 
> > > dt-bindings: iio: bosch,bme680: Move from trivial-bindings and add missing supplies.
> > > 
> > > Then say a little more on why you are moving it.
> > > 
> > > > 
> > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > There was an open question on the previous version about
> > > setting the supplies as required (which I see you've removed).
> > > My understanding previously was that it is fine to make that change
> > > in a binding if it reflects supplies that are required to be enabled
> > > for the device to function at all.  If there were previously missing
> > > that's a binding bug we should fix.
> > > 
> > > I'd like a clarification from the DT binding maintainers on that.
> > > Obviously doesn't work for other users of dt bindings but in
> > > Linux this would be fine as they were already on for any board
> > > that worked and the regulator framework will through us a fake
> > > regulator for cases like this.
> > > 
> > > https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/
> > > 
> > > Jonathan
> > 
> > That was Rob's objection so I will leave it to him, but putting my two
> > cents in for Linux it is not an ABI break because missing regulator
> > supplies are substituted with dummy ones. Unless something changed...
> 
> Shrug. I don't think we're entirely consistent on this. If we're saying 
> supplies are always required, then every device in trivial-devices.yaml 
> is wrong. Since Linux handles them missing, you can also argue that 
> supplies are never required.
> 
> I'd prefer not to special case regulators as an exception I have to 
> remember. I have some rudimentary ABI checking I'm working on that 
> checks for things like new required properties. Though it wouldn't catch 
> this particular change given it moves the schema.
> 
> Rob

Hi Jonathan,

According to Rob's answer, do you think that we can move on with the
last 3 patches as they are or do you want some changes?

Cheers,
Vasilis

