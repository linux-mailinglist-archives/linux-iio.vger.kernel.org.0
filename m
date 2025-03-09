Return-Path: <linux-iio+bounces-16647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC28A5881E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E0A3AA3A3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3645021A456;
	Sun,  9 Mar 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ1e3aDh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C646426;
	Sun,  9 Mar 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741551969; cv=none; b=SkDlIJYEjNZ4md6C3H7ODY9gXNMj63sN91P6AUxfzfeKk68EU5ZdaxZk3XGiyLldGi/ehoQiiIfcoBTlR7OYq8PDGdwZd2yVvLPzEtncB8RyioATfXIB6mGfLwFCJHrKsYGlCGOfDff7SD+l4oVauv0dQ6Xy27GybsR+pmmWHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741551969; c=relaxed/simple;
	bh=kLgToIz6b+3yQv+SLQGMuG6zZFEdsFlIaOopOyAlhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6rpt8vDURuQXX1daf9dsY0A4DQpJ5KbbP5SObGeNVHBeSDOuk0USyzbbdnObQDsKxNb9MWPNZPZb0LJDgINn8qUk80GMIzb2Y6pGdmYz3Q9ahptO96qKHuIvfQK8c3JBNA0RQMFoiw5qETLtEag45hkGf6I1QYuf3OgO5ASnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ1e3aDh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2232aead377so72490705ad.0;
        Sun, 09 Mar 2025 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741551967; x=1742156767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3RUKK26M/OG2QqGsjL0JFNHpZzmoAwqsxtczXW+X84=;
        b=aZ1e3aDhgpTHtTkzeaNRxuLldBd5DM3siC1EayU0Eb4qAYzN6rL7F2GFY5lv99cpoc
         ArYuGD5Zi4BdNbtetu/XqhDoZ9mPyFRZLoHS024bytE9YCHEQVl98t7cZkEbVBM/1Ikz
         aeI59usT3cPvJAdDQLTDnCWmtrflkQa+Nckv3mCWHwXdRDU4mSpdx6YK30jlMXNKzcX2
         egvwG5sn8L1iTi0agVGIgONBi0Rn9RwXloQktZ8tS0ST6EGuQafnJV6JIqyBkUp3swt0
         UyFD05KWBHrpNyq4nTmWL6hSWX8TraueEKjS/sxyM+ZHE1XXFs63cQiVGhQVcYbdMvH3
         Y3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741551967; x=1742156767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3RUKK26M/OG2QqGsjL0JFNHpZzmoAwqsxtczXW+X84=;
        b=gF9jPVV+12X1ckYlzwLP/UKXraz6ncXjn6reuRJ+1nptfQdhGwq/EaRM4GigUja+fX
         s5PVz7N4MEGsxNVxktIJg05PAASSBsDZdRivzYCcAanq3Wl7YAZ3ctERs6ppHH8+b6tT
         fd9L3eMbY3odeHLg6AvfB7VPd3vCtIiRnb8XKlLnGUMaJ4g4DJahbI65LPpWOoSddGzy
         VLXbsF38OTZ77aMNsiObTZ6W6rAlFJq5owlR2G8VW8fPD0SfhNXplG18l8yG61G8VXcO
         jfYrs6Y2QC2LfUd1lNYV9QPXsZPIXCUJzKNy0iPjXo5J6Hs/Sjmhi77YvWuzJO6ku7jq
         1RVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU59APN5srijFyk+HWKXDOmzJFfzR5l7lOWyZayvGvTXSKhjxPRGdqRBkejb/N0HuBNQpraaVTrnrzW@vger.kernel.org, AJvYcCUwybRZGESa8S6vHoN+a/YNUReyo6j4an2kEyeBWtJVHNxCeAu2JCFr/iUpI9ftu/bcO1ovX3XdRauc@vger.kernel.org, AJvYcCVg9C0JhcxbKCRh+ZZnqBZjo2Wh9cvzruuBuzNxNpJa5zR3ZfRlZ7vlCMtT3HWwR+EOgYAKseEK66MgziLv@vger.kernel.org, AJvYcCWIf/yYb9fmJVpjbXbJdVWwXQYWWmJhXk8kWrElVMiGuRsJGvuGcqzoDf+rF+A0LnYMv31AKJpqng/t@vger.kernel.org
X-Gm-Message-State: AOJu0YzHj49qB2OluHQAIoK3Nj6pyo8dcMl/Gl1dNT7mCHBk1Po4YHf3
	h9x1fH1yVhl08JK3KonLs1VNHb/FEdOsdrJq03ZeWZiR8ewKaKu9
X-Gm-Gg: ASbGnctSGJSzhMh7Abmi1vnKYW4yH5WRxAa8gWzYcLovDEuUQo8qItv/VIhgIdkPZOH
	AoHfgFLQhW1fkOURh5KKC67aCBOqNUaViLeREy4rjnwdLTYakmFk0FqTrfoTUop/+4W1Yb8PF4s
	bfsP9Zuf/6Raxvo6ykpMAGembPXUdBuju96IMzoUGB4l7eWGk7kkw31cZxMp4k+6ovo1S29dW47
	tI1RejAbhMEowF+Qm5LTls3rGPZ377Goub9InciVN7aZRlqyP4VXngwBRETsqCkLPhXFbNTDCim
	9n6AZ0yGuXyXFh6VHCTjx81u//M6FPPzd8Is+M6Ss/VvJb8h6RFucfkIoogsYNxUHcPPbI4A
X-Google-Smtp-Source: AGHT+IHrYpK06ZTqs/NBJWblRtG1AB6WnvmFPP/uJRhsdG3T02hn1Pj+GaVbP0SatOetqeuVXeg2xg==
X-Received: by 2002:a05:6a00:cc2:b0:736:4704:d5da with SMTP id d2e1a72fcca58-736aab14d5amr17849509b3a.22.1741551966816;
        Sun, 09 Mar 2025 13:26:06 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:2455:1853:7000:fc49:126f:e12d:f79c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2f01909a6sm5102565a12.7.2025.03.09.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 13:26:06 -0700 (PDT)
Date: Sun, 9 Mar 2025 21:25:56 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <sxul4y76upe55y4srviagtliflioar65tokeqfp4kjhpvceub3@xahz3a4rz63l>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
 <20250308151055.35cb809e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308151055.35cb809e@jic23-huawei>

> > +description: |
> > +  Analog Devices AD4052 Single Channel Precision SAR ADC family
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052.pdf
> It's this data sheet that I opened.  Seems it describes things a bit
> different that you have here.
The power supplies were wrong, the correct ones are vdd, vio and vref
(optional).

> People have a nasty habit of wiring just one. So use
> interrupt-names and let them come in any order.  The driver can require
> both or a specific one if it likes, but in future we may need to make it
> more flexible and the dt-binding should allow that.
Agreed.

> They seem to be GP0 and GP1 on datasheet and don't have fixed roles
> like this implies.

GP0 and GP1 can output data ready, chop (not implemented), device enabled,
interrupt (threshold) or a constant logic state.
In the driver implementation, one takes the role of threshold interrupt and the
other of data ready.

> 
> > +
> > +  cnv-gpios:
> 
> Not the most self explanatory of names. I'd suggest a bit of help
> text for this one.
Noted.

> > +  vdd-supply: true
> > +  vdd_1_8-supply: true
> As per other thread, supplies like this normally required and this
> one at least doesn't seem to exist in the datasheet I randomly picked.
Fixed.

