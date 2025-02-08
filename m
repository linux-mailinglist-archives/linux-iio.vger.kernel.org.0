Return-Path: <linux-iio+bounces-15172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B805A2D6F1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9413A7F03
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9342500A1;
	Sat,  8 Feb 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgNXYYKF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACA13EFE3;
	Sat,  8 Feb 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029211; cv=none; b=HIX0elKkvx9xlo9Q2wMyoWoNX/KMx1OtQTA7QTYQrdtmrS9U5yHT4gphoA//u1Egj6kCRCAYQRFI95HTh/HNxKlvq1/M0uYdrY0abUoOvjvw9cfglWNtSBOQ7gfkwd8AWpCJ9+rVgNzOjzROFJQie9FqVOvKS7c/oZb/igg4zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029211; c=relaxed/simple;
	bh=jqd741tOqz0z8M+t/1ckNM3gkRK5IGuAnhAjv3SVNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6oVVKhIqJinjYjwZUitrq0wJe8dyYP97+CRj+wZ497x0Tb4IWxrp9sFNkjpBh8rpUWmU1EARDQ61aWzAG1k9oRf6fY970wWs7ak4Jz3QxQhcv+ZTtasIovkrfeqNZnaHPs8qMG9HdYl84yU1+8UOR5TiezPyzqRyK9ZtBPHA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgNXYYKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06DEC4CED6;
	Sat,  8 Feb 2025 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739029210;
	bh=jqd741tOqz0z8M+t/1ckNM3gkRK5IGuAnhAjv3SVNHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sgNXYYKFXBnhLF21sZYrK28gEDqGVWUEQeqmeSjJZKNL9R40dgUINo+/3Wljy0LhO
	 mFaIPVZcKM7EzHlzg9dwfIYeAIg8lmVMzKn6WnzTBNg1jU5cW9o9AFRM1WADVgnGG8
	 r18zNzxyNSU1RBewhFTpche20dVD+XGyafVvC9MNl0aAMyA9F647mKWprrEg0G8WLE
	 qFzH9uz3G61Imqol2iGfO5/LYxWRMKSHpvnJdHEPYsNfpMg8Lq5NRbNd0l6OhS5jSy
	 KOw7uIzZWBfP6p0JaS6usdJBMpYcIrA2aJyU5Iszj9mTPo3igaySlx/pk2ANIszUse
	 snR5knP/migbg==
Date: Sat, 8 Feb 2025 15:40:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <cosmin.tanislav@analog.com>, <lars@metafoo.de>, <dlechner@baylibre.com>,
 <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 0/3] Re-add filter_type/filter_mode
Message-ID: <20250208154001.7d09cabc@jic23-huawei>
In-Reply-To: <cover.1738680728.git.marcelo.schmitt@analog.com>
References: <cover.1738680728.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 12:00:16 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Better document sysfs ABI for ADC digital filter configuration.
> Also update ad4130 driver to support the standardized IIO ABI for digital filter
> configuration.
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> 
> Change log v3 -> v4
> - Renamed in_voltage-voltage_filter_mode_available to
>   in_voltage-voltage_filter_type_available instead of just removing the mode
>   variant from sysfs-bus-iio.
> - Added comment about backwards compatibility near ad4130 filter attribute
>   declarations.
> - Reordered patches so attributes are documented before use.
> - Minor re-word of in_voltage-voltage_filter_mode_available text in
>   sysfs-bus-iio-adc-ad4130 to make it more generic.
> - Picked up review tags.
> 
> Change log v2 -> v3
> - Added in_voltageY-voltageZ_filter_type to main IIO ADI doc too.
> - Added filter_type attributes to ad4130 driver so it also supports the
>   standardized ABI for digital filter configuration.
> - No longer dropping AD4130 specific filter_type_available options from sysfs-bus-iio.
> - Re-add sysfs-bus-iio-adc-ad4130 just mentioning the ABI at sysfs-bus-iio instead
>   of repeating the doc.
> 
> Change log v1 -> v2
> - Split into 3 patches.
> - Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
> - Removed in_voltage-voltage_filter_mode_available from sysfs-bus-iio.
> - Added deprecation notes in sysfs-bus-iio-adc-ad4130 asking to use filter_type
>   for new drivers and referencing sysfs-bus-iio.
> - Improved commit message with explanation about use of filter type attributes.
> - Dropped AD4130 specific filter_type_available options from sysfs-bus-iio.
> 
> Link to v1: https://lore.kernel.org/linux-iio/b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com/
> Link to v2: https://lore.kernel.org/linux-iio/cover.1736261047.git.marcelo.schmitt@analog.com/
> Link to v3: https://lore.kernel.org/linux-iio/cover.1738608986.git.marcelo.schmitt@analog.com/
> 
> 
> Marcelo Schmitt (3):
>   Documentation: ABI: IIO: Add filter_type documentation
>   Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
>   iio: adc: ad4130: Add filter_type attributes
> 
>  Documentation/ABI/testing/sysfs-bus-iio       | 10 +++++++++-
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  drivers/iio/adc/ad4130.c                      |  7 +++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> 
> 
> base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b


