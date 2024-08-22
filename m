Return-Path: <linux-iio+bounces-8681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B395AE69
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D5284961
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78241494BA;
	Thu, 22 Aug 2024 07:04:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DF1CAA6;
	Thu, 22 Aug 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310275; cv=none; b=IWAVt7V9kwOtG8JG2A3rQbEIHqZSfOguwTb9C7dLI9DlGKpxRwY8brfVQG9+61+3p26tH5kNd1Il2eBIfAPBR1q7/a+XBpR2HEkJfOupLOE7BdMeR05AqGp8lM2ckD3Yh2hzGQPC1QgqiT8DNCmFYIEAXZ3uTllS1EyiUq4ZebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310275; c=relaxed/simple;
	bh=mM0y7Z0DIHWTTmDx6Rm/W7DoApVhDQcDSS/iGPnPrK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9YjWemYPW6meQ51fQTPPWTCFAghryeqU5KWGxBXfVagKDMfrpQZMspk7zvq1340AnXY8HINy/0lMRFb4qPndSsEvORkomBI9mnlTR3Cy6ta/TDQ3paF0Db//dkBYJXRL/c5+IFzmUWlVFZeRQos2tUuwsNNCW3ENjFbiTN8h6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3719896b7c8so171037f8f.3;
        Thu, 22 Aug 2024 00:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310272; x=1724915072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEZWRktZ6NYhFEZsZ7jkGwIJJMbDxgc/00AXg7Us/Ds=;
        b=BcAmURPoJlWSZJS80rCHY/S4NlKKIEFqKI4DyN63j4qfKSDm2x/YRs4CGP/ICvKUfm
         tuX3DYIZEPsQX4/PbCMmxadyI97VRka14nvw3TsiLp399zUlejzvjxq/uWiNRmwnODXh
         +OOJmAbWVlPVToWy2UmIBi+k4WfNFKuo9EaHK4YlZ3pc4xn2x4Cpc3+RshN/9tM567XP
         yzHwy4+f/Xn1DVz883EAciTGAmctatbPvdyjnfWFkHCGiVr6D/ky40rZ6NKKxhqdJP9o
         5PfrUs1vMFqu8U9Wy/w5GU+n+KZMel82yyRNL5WmaiuKeZn+m8Hdd8S92kv8ub/U15dg
         quRg==
X-Forwarded-Encrypted: i=1; AJvYcCUgaqUcQsOlt9LFaGtTxsQXeR6Wi7h8mc/1+TY00gr25P30L7GSdGjRicPLN7+WQO4Mu5pcEUARcDbt@vger.kernel.org, AJvYcCV5b/ikqzApPpAal+//XIpgQf4ea6NDbHx9TmM7oeZBd50oegMExCR2JkAgceY0SYkuXCQkS6IB6RDt@vger.kernel.org, AJvYcCWUgsVhjgtfpl44FlWDdaMpwttu9GNYjBg0PaQOPuId+AWsKJFDoTnzeyQtY0SNdD8S5FfCqRW1BC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0KleP5WKABmzU4KKLXj0r1nfkhlJaFUtJVr/3HP5T2JTq3/d
	dLZd3XSTjVhzNy4mE+PZA3+ddSMyWKwScwdp4rRr7sr66hfi8L9b
X-Google-Smtp-Source: AGHT+IHdlIILj+2ij6/76YdG9myYvO9zjSjkTKzXWmbVpdNNQ1myj4K8HPubntkMJkrcm5OdS5CtmA==
X-Received: by 2002:a5d:5e11:0:b0:373:549:bfe with SMTP id ffacd0b85a97d-37305490da6mr858381f8f.50.1724310272274;
        Thu, 22 Aug 2024 00:04:32 -0700 (PDT)
Received: from krzk-bin ([178.197.222.82])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac517a4c9sm13673865e9.35.2024.08.22.00.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:04:31 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:04:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	quentin.schulz@free-electrons.com, mripard@kernel.org, tgamblin@baylibre.com, 
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de, lee@kernel.org, 
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org, 
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de, 
	jic23@kernel.org, jonathan.cameron@huawei.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 05/15] dt-bindings: power: supply: axp20x: Add
 input-current-limit-microamp
Message-ID: <okthxpzzdduxwkgjzxi6njpkf2w7fjswi5gqhheji4owvmkkg5@4rmyye7i3np7>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-6-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821215456.962564-6-macroalpha82@gmail.com>

On Wed, Aug 21, 2024 at 04:54:46PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Allow specifying a hard limit of the maximum input current. Some PMICs
> such as the AXP717 can pull up to 3.25A, so allow a value to be
> specified that clamps this in the event the hardware is not designed
> for it.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


