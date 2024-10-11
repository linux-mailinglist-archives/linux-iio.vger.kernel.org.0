Return-Path: <linux-iio+bounces-10468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B199AB52
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0215A2845F3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D91D0BB6;
	Fri, 11 Oct 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4505Qma"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5E1D0973;
	Fri, 11 Oct 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672297; cv=none; b=E5AeuV0syw6e072MlW2cY1oTQw/w8qouio5J/5WF6ZbAEuTRAEimfF7DHTIESvyZh+K0H0G+w2lLCDNCGcz6dJ29rYq+je2eZ7bRz62jtvbuE6RKSwhhwtvrICfUXyY0XCHrOkiZvjuAkFnBRbmCZNV3/M6vVp/FkSm3dqTwyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672297; c=relaxed/simple;
	bh=vaPTkkajVisd0omUX1drL3RTAv/mBknzl71dQHcg8U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiyHioT0DCe8bu4eGVKtPmh1jYaWMfz4skKFq0ZhlO5ER9PAWl/dpp9TGe9H18FlCyZHzY3QMv2l1sxbmBgxqXcP2nqJYTGnk3ak/6PKEHZrcGb7U8FubGNnjstXealOC71DZl/KLbHE4v1fbNtLNv3qc+Lfka1h86SP+WTJyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4505Qma; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4ba20075so1354562f8f.0;
        Fri, 11 Oct 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672294; x=1729277094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDnUVuw44HrX6DXtYVD5uuvZKk3RRkB56GmG14NiOAA=;
        b=O4505QmauvK1+9n9Gy7kMqz3YMhF7o7eHdZM6ma3WrT4YhMNev21PcM/mPTM4sv286
         inOiR7DHpQf2m1eyxVTfOgcJeATuJ6aS7M7S13jRUXmczn7lQcCEYWDwlTXHayNxySBJ
         Zjsxc0W0tXVLCyCAng/54jq32dk7qF3xOZGOTgjNSCwXeGZhaPcPFtWyBsazQZinr9qO
         Hf4GiewbPf9QnPhqLMNKpHn3mDZW3tR55QoNArPMmur7KEnDeD47yKEihUKH85xKNJX9
         WAJSctviNRpUR6YkdgJ/ymL1hF49r1SSUvCdxAddQC/wtq2mKr6Yf5arDlySDr2iZ/hZ
         xulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672294; x=1729277094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDnUVuw44HrX6DXtYVD5uuvZKk3RRkB56GmG14NiOAA=;
        b=CivLI9URgq2F/niY309k9kPGkcwF8mGV9qoZX2QB6Yljng2Ut8bn19dIfetgYUtymx
         Gn8GpxVJRGdFXt8MgqpyFyCBRczuwLtnfZlsu/Hx/WmakgTYlefh+nPf58IBqVd3i36e
         FXpXX8vANK9R5ejVXfoFjzhK3mRbb4X9GTEDKXZRlkViGF5ugvAh0aWSVa0uv3MH9RPZ
         TB2sAVunsP6IF5TCDZ3aoxF2ZB3iiq2GeKpQf8csjuSlSI+BuzPIiAPJDwJ1frN0WKLO
         o5/57yuUsPuyJzMaCD8Fq6gTNccNjqsAvqtVOwpgaVroqpboaVm099ngjzD5cIM6VGU7
         8PQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUtUSV9DMy8NMq86kbclVU+i5JqvOv4D3c4k93am0tJafBWw93IllrKNaN0635sG9GwDSrj11FGouT@vger.kernel.org, AJvYcCVgb5fsccYGDpWkYZJG1Z5AIjrAEyerVui1t2UqTiE457KT27G+IhqjdRoo7bDnaYCkfJKycTRZ8Xdb@vger.kernel.org, AJvYcCXomG5pAc0OhAEMjYmU4THBUgLEktekhUu2WXx3gjOR+ryGc/WSWBgXt7XhpcFQXe/G6Pf6ib/Uq2ZOxB8D@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHJ9NNbFD69wWiwy5qiAw03wKZXysu2vahhMbL4HcoPEcYNg7
	z2GnHXsh0t5gzsZx1zkgaKI4qVCzSYoJOgbvFwvLlPl7OzAlylGH
X-Google-Smtp-Source: AGHT+IErikHcY1GOpaRQHPzeCuSJtyLERjtZsWeiRxeKkL7FPJlBtNjaDzeS32ZBbWBt8pbBy+UPMg==
X-Received: by 2002:adf:ea49:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-37d551d39b3mr2497736f8f.22.1728672293819;
        Fri, 11 Oct 2024 11:44:53 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7f2c1esm4520879f8f.109.2024.10.11.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:44:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:44:51 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/13] dt-bindings: iio: add binding for BME680 driver
Message-ID: <ZwlyI3DasF7PEVqE@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-7-vassilisamir@gmail.com>
 <9fc325ee-0c14-4d17-a0a5-8cf35a8ce245@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc325ee-0c14-4d17-a0a5-8cf35a8ce245@kernel.org>

On Fri, Oct 11, 2024 at 08:51:00AM +0200, Krzysztof Kozlowski wrote:
> On 10/10/2024 23:00, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Add dt-binding for BME680 gas sensor device. The device incorporates as
> > well temperature, pressure and relative humidity sensors.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> 
> The device is already documented. You need to move it from trivial devices.
> 
> Best regards,
> Krzysztof
>

Hi Krzysztof!

Thanks for your time to have a look at this!

You mean to keep this new dt-binging and remove it from trivial devices?

Cheers,
Vasilis

