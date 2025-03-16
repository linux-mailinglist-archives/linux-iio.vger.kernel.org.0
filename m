Return-Path: <linux-iio+bounces-16920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A338A6378F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 22:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C263916D155
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924161DDA15;
	Sun, 16 Mar 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av5BSeRe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DAC2E0;
	Sun, 16 Mar 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161450; cv=none; b=PeDJMBNXNyDViv3c24l8+TRAISi0GoGY5AqmiuKisQA3yzAETfal2hsjJBn2mVWXoEOYutZv4/KH966/jaQKyjfj//7dboGj0ZCraYQtBqzOQYA7lft8mZS9nqUPYOLhMc0TO6cp9HEPcvPBF0Zy9kIvyDvp9Btr03+BG0Uws8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161450; c=relaxed/simple;
	bh=v4P/KcddWLuDTatda/HBTqKygV+7kfJ09+a2eRbRlKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn25GvPr55MUD3/f+AMvfaaW/1R6cxNLfEiEPxEVoIw1Wb+QNF/qpHEndf0pOnnZCZiQcQJ3ECLMtNau/P0YWcRa4aV21to+Ewv0GpBu2hFPkQH4oUw2nOHqZnD3bfm+xYpNYbowKOJGRrVAsDq+96+5n8ktIGJQz64yp0KRSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av5BSeRe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso66748345ad.2;
        Sun, 16 Mar 2025 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742161448; x=1742766248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mKilVKnBM4oRzcS1cLG80AavsaCOJuEZgc8LXHq/UQ=;
        b=Av5BSeReNpTZbMpAoy6k2um4wrkL6vvvqb+NPR88d39OASCl6b3tM1DLLen/A3He73
         0s0cpWxUwSMJThtIH6YlZ/0TbzvUvEGHuGDhIH1qu0UuYYtlRy/byia/WgOlTs5E2/jB
         fVfFUq2f74rHFKkcOVx+OrOIxYfVfWgFxeJ6QExnaMpO+Rx9sz8wAB+mIElTGZaHpyOk
         U0bTtwFa65BfnyzSKKZ4Beul70s1SF0mgwBugsx6fr08WBihuJUmXvHySaMBqcmto6S5
         OxNtqJeFeGcmOAbxtMW/V3LN/0YIIjqr6nbkKZFCaCLOQDcA20e4ehd18ygRJsYUbuIC
         j9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742161448; x=1742766248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mKilVKnBM4oRzcS1cLG80AavsaCOJuEZgc8LXHq/UQ=;
        b=fWiUwyV1CLhbPkZWplhltVHAvM1/YTYS6GQf5bdA/1TuaLlWrihIMwrkH02cztK3Ds
         Jfnbrrau9UrTkPrGaeKRgHC9AgIg8ci1RbHGpu8G9cpkreoom31IEtZ07bNCmducvJYH
         woev2wIWoMqieWbcDiW38qJ748xVsfUxqYw4xbKo0b+aFme1j/RqPUVJFuVDuj8xeMj9
         DhqDvTZWi5W0dkToanmD14bXfsJ84/HtHcqdGiG6O/eofN3XVQXUZypz5QC57s+2OdaM
         t5hio40/SqAcoUUq2b6MuL2WzZVAFAyyKAf8nnDSK4IEfLEqTXR7wiYg+tU/YgUJt0oW
         BJyA==
X-Forwarded-Encrypted: i=1; AJvYcCVvyH+6BA7OBbcY2K3AfR4nc02eWj+8RcuyO6Q6WfdwZa58jUFNuZRhXZfO+sYIJp+slxwQw7fdp3VN@vger.kernel.org, AJvYcCWJJ9jJZiOwNwL1NZPTOJQraPf6+1cWKMHKHPBv5yIo6BF0EWVFSJz/96QuXt+MTARlApDOMS4av5urYg==@vger.kernel.org, AJvYcCXUh9WcZTijg5tFsWzUmJgVLd80YfJwaq7b0B9GSFQmiYquljAbyDVgdRm/4Fq6BA4lGYUAA990@vger.kernel.org, AJvYcCXUrksHAFWGgjRznA60golSCLgeNdmTAZjjxATHNTG+p77m4zT60YtK5nyzBg7Ovf3uFgjb+6rdQDEqYoVW@vger.kernel.org, AJvYcCXV4oqnrC35ub3xEQ+Ld9NMaRJvszJu9RbmowvCo/RoT1GL8Y/qigaNa+YqUtL5yFZ9OYFUXf8gGlHF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0w7sS0GLYq2IxOa17gWb+4repDhbALPpS646WsUQnQq797A3p
	tgmo+U0LCMb39MV2GqkYnqItwGtBtMajDMKlRZ64uB78rcGKhx9F
X-Gm-Gg: ASbGncuydSPA1/Dht+Iz0uYUXGvolnFpKiy9GSSLJnpEW6KVlhVfNcvvTGi//nwVgc5
	Mz929IzbceOYuzfeXoIuDQ2MCBnU7nocPqg9DBDX5t8XOzBg/YDX22J6aQXmZseS8gTnIMJIV7N
	WkaMqTYMNcZT3lXd8Xl6N2NO6cbgAPvXpLfmIS1Rw/A0K46s2sRRpU+phxi/jR1cDqzXBFdv4cZ
	j/5GGm0h+cQcjlehgA4hvG7Tuaj3i/sfIO5T1d1/0H+G/UwsgwkWgTsSk4eR4vFIW/TDTkxMJHN
	zyAe9Lh6ydY+rOHCIQ9y+Yk7fjKg/PU7ri2IcATOlmfB7//Lr/a3JQ==
X-Google-Smtp-Source: AGHT+IHk3fWjPG0Lq3bYmcMnBWXcJVnNnmjKprgtboThBoy1lvBE5vc2ZBXIYdbzt5jjuHpjlPKXvA==
X-Received: by 2002:a17:902:e74c:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-225e0a40bb3mr144393215ad.12.1742161448027;
        Sun, 16 Mar 2025 14:44:08 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c688858asm61634375ad.46.2025.03.16.14.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 14:44:06 -0700 (PDT)
Date: Sun, 16 Mar 2025 18:45:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 02/10] property: Add functions to iterate named child
Message-ID: <Z9dGX_ckIRUg6fZh@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <f613b5f120a4dde63d28b0a2e0186dcb8dbf57ae.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f613b5f120a4dde63d28b0a2e0186dcb8dbf57ae.1741849323.git.mazziesaccount@gmail.com>

Hello,

LGTM, few minor comments inline.
With those sorted
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 03/13, Matti Vaittinen wrote:
> There are a few use-cases where child nodes with a specific name need to
> be parsed. Code like:
> 
> fwnode_for_each_child_node()
> 	if (fwnode_name_eq())
> 		...
> 
> can be found from a various drivers/subsystems. Adding a macro for this
> can simplify things a bit.
> 
> In a few cases the data from the found nodes is later added to an array,
> which is allocated based on the number of found nodes. One example of
> such use is the IIO subsystem's ADC channel nodes, where the relevant
> nodes are named as channel[@N].
> 
> Add helpers for iterating and counting device's sub-nodes with certain
> name instead of open-coding this in every user.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
...
> +/**
> + * fwnode_get_named_child_node_count - number of child nodes with given name
> + * @fwnode: Node which child nodes are counted.
> + * @name: String to match child node name against.
> + *
> + * Scan child nodes and count all the nodes with a specific name. Potential
> + * 'number' -ending after the 'at sign' for scanned names is ignored.
> + * E.g.::
> + *   device_get_named_child_node_count(dev, "channel");

The function being documented is fwnode_get_named_child_node_count().
Shouldn't the example be
   fwnode_get_named_child_node_count(fwnode, "channel");
?

> + * would match all the nodes::
> + *   channel { }, channel@0 {}, channel@0xabba {}...
> + *
> + * Return: the number of child nodes with a matching name for a given device.
> + */
...
> +#define device_for_each_named_child_node(dev, child, name)		\
> +		device_for_each_child_node(dev, child)			\
> +			if (!fwnode_name_eq(child, name)) { } else

nitpicking: add only one tab for each indentation level.
	device_for_each_child_node(dev, child)			\
		if (!fwnode_name_eq(child, name)) { } else

> +
>  #define device_for_each_child_node_scoped(dev, child)			\
>  	for (struct fwnode_handle *child __free(fwnode_handle) =	\
>  		device_get_next_child_node(dev, NULL);			\
>  	     child; child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_named_child_node_scoped(dev, child, name)	\
> +		device_for_each_child_node_scoped(dev, child)		\
> +			if (!fwnode_name_eq(child, name)) { } else
> +

nitpicking: instead of two tabs, only one tab before device_for_..._scoped().
	device_for_each_child_node_scoped(dev, child)		\
		if (!fwnode_name_eq(child, name)) { } else

Regards,
Marcelo

