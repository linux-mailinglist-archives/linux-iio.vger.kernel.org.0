Return-Path: <linux-iio+bounces-16440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E0A53EC6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD08169CD6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F32114;
	Thu,  6 Mar 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQY3jNOo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156A367;
	Thu,  6 Mar 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219311; cv=none; b=nTuODKoqG9cxVOvJNX03YbZ5R0aWCllvjqkOXyp12UYQZQlIx7VL1GddHEvQQRVeTQMYGXzEBQsp4Li6A95o0UGZFeZXaib+o1MFyRY4B+rG3bHguLbaRNv+KWx8GlhI3zVLaqdqNRvWRgPlX1DhlbnaKBAiIxM4eERJISd/gZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219311; c=relaxed/simple;
	bh=azxlGePwOlFA7zcE0N3ZDl8+Ny9Zkx377il0JTO8MG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAKCtEcoWOjj4q6LcHQTiomMlznUqFGTdPtf3V4c219TDD8nR5nzaigUPS0DaXTguXP3Um2R2fFbMm1xFa0yCzeHCnha4TctK1U44WQLbtlNHxxkR9OqOXmodsK17HClf/7/y9E2Eplgg4z0POnLTX2RrHaKciH0crNAtZpjWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQY3jNOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35488C4CED1;
	Thu,  6 Mar 2025 00:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219310;
	bh=azxlGePwOlFA7zcE0N3ZDl8+Ny9Zkx377il0JTO8MG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQY3jNOoCTqdU4vTPCjeXnOwgKa7GfKQYUou91frUhAgjUwUZpl4E11vgHD0RAjBb
	 SYh0JnHNYWbdB6tMQutB6nJYR/wBmGfdJjesBAoEd9El3MU9Wme7yzSYLY5Nyi9pz4
	 LmSvx8EO4a2FJ4uFahl/InA/mPT2fC6qq8WxZosMN4pTTiKAwsQsrZAAPLhZmf00nf
	 qLsqCwUMJWy93wH+bGQzufJRtKXIuj9DWBl4eHTHPckG0umgWPMJnuT0ePcU9QGqv9
	 mqMiyDj3ET/u/0BTxhQ1NsiwGKX/EHvtGkvGlY33VANia95wsTaEJh5RbfFsHMQtc8
	 nsm6LNd61CFoA==
Date: Thu, 6 Mar 2025 00:01:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ramona
 Gradinariu <ramona.bolboaca13@gmail.com>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH v6 0/3] Add support for AD7191
Message-ID: <20250306000136.7de51170@jic23-huawei>
In-Reply-To: <20250228141327.262488-1-alisa.roman@analog.com>
References: <20250228141327.262488-1-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Alisa-Dariana,
Looks good to me.  Applied to the togreg branch of iio.git and pushed out
for now as testing to see if 0-day finds anything we missed.

Thanks,

Jonathan


On Fri, 28 Feb 2025 16:05:59 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> v5: https://lore.kernel.org/all/20250226115451.249361-1-alisa.roman@analog.com/
> 
> v5 -> v6:
> 	- use GPL-2.0-only
> 	- remove kernel.h
> 	- remove unused macros
> 	- initialize local indexes
> 	- check number of gpio pins
> 	- use bitmap
> 	- inverse if condition and remove continue in 2 places
> 	- fit .compatible initialization in one line
> 	- change MODULE_IMPORT_NS() content to string
> 	- use iio_device_claim_direct()
> 	- refactor heading levels in docs
> 
> v4: https://lore.kernel.org/all/20250203133254.313106-1-alisa.roman@analog.com/
> 
> v4 -> v5:
> 	- use static arrays in the ad7191_config_setup function, instead of keeping
> them in the state structure
> 	- added error checking for devicetree parsing of pga-value and odr-value
> 	- for now, it doesn't return error when the index corresponding to pga-value
> or odr-value doesn't match, since index is initialized to 0, so it will use the
> first value in this case (the bindings constrain the possbile values for these
> 2 properties, so I thought it's ok like this)
> 	- use gpiod_multi_set_value_cansleep()
> 	- move sampling frequency attribute to mask separate (the avail unmodified)
> 	- removed unused argument form ad7191_setup()
> 	- removed 2 redundant sections from docs, and renamed one to Devicetree
> 	- add ad7191.rst to MAINTAINERS
> 
> v3: https://lore.kernel.org/all/20250129143054.225322-1-alisa.roman@analog.com/
> 
> v3 -> v4:
> 	- addressed all replies for v3
> 	- refactored the scale and sampling frequencies configurations to use 2
> different arrays for gpio case vs pinstrap case
> 
> v2: https://lore.kernel.org/all/20250122132821.126600-1-alisa.roman@analog.com/
> 
> v2 -> v3:
> 	- correct binding title
> 	- remove clksel_state and clksel_gpio, assume the clksel pin is always
> pinstrapped
> 	- rephrase clocks description accordingly
> 	- simplify binding constraints
> 	- specify in binding description that PDOWN must be connected to SPI's
> controller's CS
> 	- add minItems for gpios in bindings
> 	- make scope explicit for mutex guard
> 	- remove spi irq check
> 	- add id_table to spi_driver struct
> 	- changed comments as suggested
> 	- use spi_message_init_with_transfers()
> 	- default returns an error in ad7191_set_mode()
> 	- replace hard-coded 2 with st->pga_gpios->ndescs
> 	- use gpiod_set_array_value_cansleep()
> 	- change .storagebits to 32
> 	- check return value for ad_sd_init()
> 	- change to adi,odr-value and adi,pga-value, which now accepts the value as
> suggested
> 	- modify variables names and refactor the setup of odr and pga gpios,
> indexes and available arrays into ad7191_config_setup(), since they are all
> related
> 	- add ad7191.rst
> 
> v1: https://lore.kernel.org/all/20241221155926.81954-1-alisa.roman@analog.com/
> 
> v1 -> v2:
> 	- removed patch adding function in ad_sigma_delta.h/.c
> 	- added a function set_cs() for asserting/deasserting the cs
> 	- handle pinstrapping cases
> 	- refactored all clock handling
> 	- updated bindings: corrected and added new things
> 	- -> address of the channels is used in set_channel()  
> 	- addressed all the other changes
> 
> 


