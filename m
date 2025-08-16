Return-Path: <linux-iio+bounces-22834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094FB28EA8
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CE75C6070
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6D2F8BE9;
	Sat, 16 Aug 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp9kSPKQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D92ED179
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355952; cv=none; b=bVJzfQ5ZmIJ94X+zgit/ZNeCZMAqjrofdkcaNfmgSmjnR7MFgdlOyOiEc4lJJOTsAHn3v2zqgq+rRPu7hgmmHHdFDVVlYmvFM4E8Fjx1ilvJrZBzL+W0v71jlgVXvTvcQptic89V3N6NsmQVk0KXLZ67vLhNfCnPYhQr/q3zjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355952; c=relaxed/simple;
	bh=QFt3xhjxTme1MPXCxd4DAFSXM8AkxGmTrrjotxamflk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFNsNfsEoQhdSsK8vTlKUnLiW6jA8exN7du9T4vkK+d5xchmmX0BF5C12iNDDq7xeV1UQCJycaLfMOyFxX6HxZ5m0MF2ZmTyc/FHV6G7TGDjf+/SYHEZc4xtvpKoVStVdahn0lvxaeje9IiMdceItpTBW0O8OHfuqu7n8qUe4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp9kSPKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0563FC4CEEF;
	Sat, 16 Aug 2025 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355952;
	bh=QFt3xhjxTme1MPXCxd4DAFSXM8AkxGmTrrjotxamflk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tp9kSPKQ2+a4quDq/ZFTMWZWCDSEZpLViBbQeQEFAUmbrEe56VqA63PMqfvYqEjNr
	 R5tve7903TJVvR1ghUG1+AevMgeA8TI7yVdmCJr95BJka54ijQAHsNPvc8pSH0qq8r
	 Q8Ap9X6qBsWcvneB2bpHF2k/pzTGwbZ1rT03nwlC2qX0TKKWPdRBdc8XkMeujulPhh
	 4wiQfQ/Qu6PXq2KhVg1ezSRH6LecafydkBmBz5dgTO5/PahZy4NrE9pi/VV2EsgEdp
	 DO2nsKPRxTRO/DcuPdDAj/d2HonwnmEv5EXuyT1XL/z/iay5bkwi+/DjIZIlHz9Gsp
	 q6UPtsewQ3zNw==
Date: Sat, 16 Aug 2025 15:52:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/16] iio: light: adjd_s311: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155221.51ebb32d@jic23-huawei>
In-Reply-To: <2cf08478-ee73-45d0-b922-617349d33a7a@gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-9-jic23@kernel.org>
	<2cf08478-ee73-45d0-b922-617349d33a7a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 10:04:40 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/08/2025 19:44, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Also move the structure used as the source to the stack as it is only 16
> > bytes and not the target of an DMA or similar.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.

