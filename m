Return-Path: <linux-iio+bounces-21054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F02AEC8A1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915E53A72A7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161821ADC6;
	Sat, 28 Jun 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n493gcA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EC1C8630;
	Sat, 28 Jun 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751127483; cv=none; b=s5846H2wF2EDUAtAdd9bzzLrPRYGwN1iAcd3F0XpyO7UTNBIjdeoJMvnDZ/SqWywaFk7KqSG0LEVnW7dPLc3IMi9iS8cd8tpHtmT68TaDp08SGUC3UaQrloLqt0SrXe6wpe12JpPIkOEtYrL4h0fhh8p0zUFIltxGtVTpW43EQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751127483; c=relaxed/simple;
	bh=ZkcBKDm9jTCv0iMyBZzbsIcDLx3uCw5+ifRdmE+ees4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etvvxLC+w6JwKlX5R+yj8mK8NLDMN+lHgMvMFiz4Oz2dPzsVb34eH6VkSIH6hBf2alh8fpU+BMUzE5zjPuoTlnz2svVBtmRoz/3M3tQdSrzdBryj3wRMxRb/aERzEq3s7bBSag1bEy2bjBBP0DuepTw77idQN41+npGI8yDExu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n493gcA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504EC4CEEA;
	Sat, 28 Jun 2025 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751127482;
	bh=ZkcBKDm9jTCv0iMyBZzbsIcDLx3uCw5+ifRdmE+ees4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n493gcA0REz7iH38jkhWRrryC/C7uh4qdGwgAIEGhrOwwmYAgbeDyIsj3FJck7SEv
	 KtWhOowQIIuLCvD2zOJzNmjIMNYW+gIhIauMlsAdr4jrGae+myMukD5IZbfOhVw4oj
	 AgozMHUZnHmGht49yg2e2gWJtfmXnY1G/pIrz0OtWplX9ovdEm0iKyp8yoBPvkS+ZM
	 ln8H0lvGI9Jg5CMP5H9kVkSdSOOics4wJlimnjJiDgKWUuLvQBJFAlKPicNhBZh2SI
	 rRbJLqdcCmOe89oML5Y+di9u+yeqemBmiPZouRhRfZksmRy1SJYfouFb9MFTgW/j0P
	 kWaXjrKzYvdDA==
Date: Sat, 28 Jun 2025 17:17:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v10 7/7] docs: iio: add documentation for adxl345 driver
Message-ID: <20250628171754.214e4186@jic23-huawei>
In-Reply-To: <20250622155010.164451-8-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
	<20250622155010.164451-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 15:50:10 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
I'd add one more patch after this to talk about inactivity vs freefall and the
restrictions around that.

Do it separately rather than integrating in here so that it is easy
to spot that potentially controversial bit.

I'm not a huge fan, but I think it is a viable way to support what we have
here.  I'd kind of like a nice bit of documentation to cover what you have
in the patch description of patch 8 just so we can remember what is going
on with out checking the git logs.

Otherwise I took a quick look through the rest of the series and didn't
have anything to add.

Thanks,

Jonathan

