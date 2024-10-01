Return-Path: <linux-iio+bounces-9990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8298C873
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 00:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A97F1F22602
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B161CEEB4;
	Tue,  1 Oct 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgQeuwJT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPUnuC+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E51CCEF5;
	Tue,  1 Oct 2024 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823277; cv=none; b=Lua2n8x6EmliJXLkkP7tTJ22ZySMr2uDer1Ousxw4KUvDNLAzYOJQ7pbEfXSiJcHpNlzPmUFsd26lP/g/spk9JiDjiNn2Mfcl8nljZqwqlLhSQn+ZESQNEghL3xXjnFQQ81yp1D5tY17e/dkEI+13LqmK7gWw0ah8kixmeo7bH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823277; c=relaxed/simple;
	bh=UpfF7AB51gMACdFfukqmKWR7ALWtGeBabwO0eiGZLiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkvBbHB3BHAWpJ5zjs600W/4YqSuDyL4mODoUzOBETnMLIUg2/fKnA15EgTEjTAbF71TwFJGxoBJNl9EVrRuX6g9+K67Vw/NbYjUdgx2VWAu6LhRxZc4bmy7sWRmvyDvm7TLt2VDkoqtHJccuDczfFGrUWjJgVYlU1smylnRODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgQeuwJT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPUnuC+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 00:54:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727823272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkWIackqZUxS3tr2YwCMU+zBvBxG5iwmTKZOZDqpBfM=;
	b=EgQeuwJT7fdDS9dSeJ0RXdh8Wne8x3dk02CX5jWNxGYiUSE4374n84mJAdsDil1Wrjpa4h
	xukSAcFEzct4HCt5UesGe5PsNMi0P600K6/1KQdgLeP65SKm+UjDa6JOkPKIjnN1iPO01c
	voO7t+B5E8GUL2elt3DuiovzE7HX58c2kwewWdkZeT2TO4dgcys4GRydNYJtAPMRl4dQrz
	Mtmc27pF5xqgBuCNPg+JWNMpqy8+WCnyn0JrcgIqaiYY4rb7FlcVUpMxVpw3VEyokpz/m8
	uaFMQKsJPgkCdS9cdLlusIBozUTOLlxKAmmLE8vQc/hzh9P3VaR8a81GbxqPgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727823272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MkWIackqZUxS3tr2YwCMU+zBvBxG5iwmTKZOZDqpBfM=;
	b=LPUnuC+Cl1qWPL1NsgH8eUXrIWTFf62Yu2HC0+q69K9aHAuShOuEEcRnMlxs0aDTsakLj0
	Y5iQoT8GOCCUf4Cw==
From: Nam Cao <namcao@linutronix.de>
To: Tudor Gheorghiu <tudor.reda@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: rename macros
Message-ID: <20241001225426.wUBOFdMi@linutronix.de>
References: <20241001202430.15874-2-tudor.reda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001202430.15874-2-tudor.reda@gmail.com>

On Tue, Oct 01, 2024 at 11:24:30PM +0300, Tudor Gheorghiu wrote:
> The frequency iio drivers use custom defined macros (inside dds.h) in
> order to define sysfs attributes more easily.
> 
> However, due to their naming choice and the fact that in some of them the
> first and/or second arguments are decimal, checkpatch will throw errors
> in the source files they are used in (ad9832.c and ad9834.c).
> This is because it thinks the argument is _mode, therefore
> it expects octal notation, even if the argument itself
> does not represent file permissions. Example:
> 
> ERROR: Use 4 digit octal (0777) not decimal permissions
> +static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);

You probably want to elaborate what you mean by "their naming choice" (i.e.
how does the naming choice causes this false warning?)

I got curious and digged into checkpatch.pl. This script expects macros
whose names match "IIO_DEV_ATTR_[A-Z_]+" to have the first integer argument
to be octal. And this driver defines macros which "luckily" match that
pattern.

There is only IIO_DEV_ATTR_SAMP_FREQ which matches the pattern, and accepts
umode_t as its first argument.

Instead of changing code just to make checkpatch.pl happy, perhaps it's
better to fix the checkpatch script? Maybe something like the untested
patch below?

Or since checkpatch is wrong, maybe just ignore it.

Best regards,
Nam

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..2fb4549fede2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -817,7 +817,7 @@ our @mode_permission_funcs = (
 	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
 	["proc_create(?:_data|)", 2],
 	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
-	["IIO_DEV_ATTR_[A-Z_]+", 1],
+	["IIO_DEV_ATTR_SAMP_FREQ", 1],
 	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
 	["SENSOR_TEMPLATE(?:_2|)", 3],
 	["__ATTR", 2],

