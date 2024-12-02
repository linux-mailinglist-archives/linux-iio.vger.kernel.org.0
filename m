Return-Path: <linux-iio+bounces-12976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F439E0D9A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A06FB29212
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158E1DE4E7;
	Mon,  2 Dec 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="a5aXW6xE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F41632FE;
	Mon,  2 Dec 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168800; cv=none; b=ocFkWWV2O31hRM+4ubLiouazzB8yJmsK5TFc6H85l7PeXUCJk6RrkA+i0llh3AcSC4YP9JQ/xactnvo7Boc7vpY0tF1EWcIsap4364LlM4ynODALj2varJUphCliFuhdXwJk68m9I2ZXztZiAhRx+N0m6te2MADowyIKgztLxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168800; c=relaxed/simple;
	bh=3haBNkwOa+kWFF76mDBO/TYliaMdWZjsIVvMfBESL0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzCXEDG89iYgtTTrbyEiLDCmdS9hEgyYecw0rXaUYceOper0RfV7Nc5vpnDA5f3ui1iZXwOlsMXBnqmxd00Dy/J2nPyUgB//ar/kjlr/raeyYDY3C/Az1VcwCZ9vUIHY7f2zxLxmtV3wOAwhVzn6mvnslkLdhecmHX+awDzcXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=a5aXW6xE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 6422D20663;
	Mon,  2 Dec 2024 20:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1733168787;
	bh=jn6wwfgyaiwuBcq0vzx9I1PrVueUxvuRTvuoe6+yuyQ=; h=From:To:Subject;
	b=a5aXW6xEHRaN0EOip4z4BCJ98iBGGvqF+lywycOm9AB8IZifEPFRCQV9UhgEkvtST
	 RR1ZsjGOiRWHhDG+yiN0i0ErgcRcyOMG7CMZZgv89l3bAjp9UidjnoI/ZU/ocTonsv
	 EpIwZVyxrWcBkpc0wrI+wbPkmxIczFqUZYLEtSxOMdf0KqKyCSyE1BGlfXbT6kbnKa
	 uYd+AtYqjflRD659h0X/fs8JWLNnWUFyIMi1Q0tD+sXV/UC+QoG5WGzG9q5wZ/HSHJ
	 knGd1RSYfCK/yNn8GUPt9mDH7YxJ0bxO4OOAjqSAa5hdjVNRxaGd+RTxDXEMGfZxdC
	 DaS2gf78B2e5A==
Date: Mon, 2 Dec 2024 20:46:22 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: fix sample size in scan struct for
 triggered buffer
Message-ID: <20241202194622.GA70146@francesco-nb>
References: <20241202-ti-ads1119_s16_chan-v1-1-fafe3136dc90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-ti-ads1119_s16_chan-v1-1-fafe3136dc90@gmail.com>

On Mon, Dec 02, 2024 at 08:18:44PM +0100, Javier Carrasco wrote:
> This device returns signed, 16-bit samples as stated in its datasheet
> (see 8.5.2 Data Format). That is in line with the scan_type definition
> for the IIO_VOLTAGE channel, but 'unsigned int' is being used to read
> and push the data to userspace.
> 
> Given that the size of that type depends on the architecture (at least
> 2 bytes to store values up to 65535, but its actual size is often 4
> bytes), use the 's16' type to provide the same structure in all cases.
> 
> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: stable@vger.kernel.org

Thanks,
Francesco


