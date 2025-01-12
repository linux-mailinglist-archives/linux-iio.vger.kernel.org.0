Return-Path: <linux-iio+bounces-14241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D445A0AADC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C9A18852E5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A21BDABE;
	Sun, 12 Jan 2025 16:29:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C51BD9E3
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699387; cv=none; b=TaeOwQ+F9eRaoKq+EHeoxzKZmp2WqHgzMA1VDpI734WqwMR9fgwjs3mzg0mRaq7COsMRcOP5HJj+HSLKRoWo2E8nEGsnjS+bN2xmCVgVE81xX4TGRPYvll+UMtBV0nAYGT4Sr8+oU9MTx3s4u3/EGSEEFCZGpHaDj4N9p+4LPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699387; c=relaxed/simple;
	bh=pafjelIF8w7HMb5e41lGceWaRWXL4eViG5SvwC/7Ul0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvYCMxi3LVHJndo89Hy//UNLNYvQCg6g6Y6WNrEBJhP6zcr78dE9S8u/NTkAp32zF/P72YS5bhuAL8wmPLHPY7lKg0q+RUzDvrJ1rsHbjlvp7qIXfmUir5mJIzgcr3qHyp8b+nTe103U87cCrAWlMf7w08VJDQhKXbJ3xZFXzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6d1c8af3-d102-11ef-88a2-005056bdd08f;
	Sun, 12 Jan 2025 18:29:42 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:29:42 +0200
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <Z4Pt9oZEkfQMuYUm@surfacebook.localdomain>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
 <20250108-ad7380-add-alert-support-v4-1-1751802471ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108-ad7380-add-alert-support-v4-1-1751802471ba@baylibre.com>

Wed, Jan 08, 2025 at 01:49:33PM +0100, Julien Stephan kirjoitti:
> Conditionnal scoped handlers are turning out to be a real pain:
> readability issues, compiler and linker handling issues among others so
> rollback and remove the scoped version of iio_dvice_claim_direct_mode.

Is it IIO level decision or you as a contributor to/maintainer of this driver?
If the former? can you add a Link to the discussion?

Otherwise, I would like to understand the common approach / practices in IIO
WRT individual drivers to deviate the common approaches. Jonathan?

-- 
With Best Regards,
Andy Shevchenko



