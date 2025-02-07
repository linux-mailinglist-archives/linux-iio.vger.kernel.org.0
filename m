Return-Path: <linux-iio+bounces-15102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C2A2B872
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 02:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CBE1888FBC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 01:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6E13D8A0;
	Fri,  7 Feb 2025 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="wVohw3de";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="wVohw3de"
X-Original-To: linux-iio@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D14C6E
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893160; cv=none; b=MC5FdSLhg4aYJFBoIhjLTnOya1lwdUycrFrE6HbSO4SN18BjQji0jBgnPO+KSEPsh8r015sA1Rv0/wuBcFJt/F9+FUsgfeGZcAYxVjbV+khhz2umzE3NsaZ1lPQ/FLKgXCeHfJsNXLD7q8UdF4b3RbeQ79BA86/ovrpZpv9MUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893160; c=relaxed/simple;
	bh=r0kZrHvJRwXYn7/S+H4LU9u8Ge0Wn6JBgeoq/b8xAZ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxxzM/7LQSUNxqE5Aai7nmYhGmiIQeApw5Kezihs0LTgiwBx5GdwlMOg6uJbPa2JvWjP2vTgjcXDmv4EKSfnGqYInNIopds28sly7Gz600OZO4Q0c7cnD5R4jSVaWmgGwbV16X6+PIN2yMq6k3vPLii10e83OqKLZmKr8RSbvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=wVohw3de; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=wVohw3de; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1738893153;
	bh=b5tsJ9IVoLzPvlvNaZRaTYlZIQYgWiHP9Z3oKbMUjRE=; l=576;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=wVohw3ded4x0nHYo1T1wk/5rluTnnhEQIcTWxR2r6OOPfLX36p2QQAA+49Gzo3+C/
	 kzknQVUAO4BlVxwwVS1AMm3yhJXfWzLx/WjLFi1vfhrhbefuuthOC7AVlebz95iuJK
	 OuoUtOBgzCszkWdUrgH7RXCKtqo24PlPS57RPfSMIMWLhD2vDPKiA3A4h2iyHhaGBY
	 nHSpYQW8faZj7qTZzSIM7lx2wUlUviA7+1Dz5ow0kQgS1uHGazLfRyR0ixjiM03iLX
	 aN/opEHDgt8IU0m88NLglJsA5DtpCm1Jp3lHPxu/IWStnY8eFbHEyxIk4lTDO28hFZ
	 EJXsu6ssv9GEQ==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128086:0:AUTH_RELAY)
	(envelope-from <prvs=112852FFD6=cy_huang@richtek.com>); Fri, 07 Feb 2025 09:52:33 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1738893153;
	bh=b5tsJ9IVoLzPvlvNaZRaTYlZIQYgWiHP9Z3oKbMUjRE=; l=576;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=wVohw3ded4x0nHYo1T1wk/5rluTnnhEQIcTWxR2r6OOPfLX36p2QQAA+49Gzo3+C/
	 kzknQVUAO4BlVxwwVS1AMm3yhJXfWzLx/WjLFi1vfhrhbefuuthOC7AVlebz95iuJK
	 OuoUtOBgzCszkWdUrgH7RXCKtqo24PlPS57RPfSMIMWLhD2vDPKiA3A4h2iyHhaGBY
	 nHSpYQW8faZj7qTZzSIM7lx2wUlUviA7+1Dz5ow0kQgS1uHGazLfRyR0ixjiM03iLX
	 aN/opEHDgt8IU0m88NLglJsA5DtpCm1Jp3lHPxu/IWStnY8eFbHEyxIk4lTDO28hFZ
	 EJXsu6ssv9GEQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3140704:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 07 Feb 2025 09:47:29 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Feb
 2025 09:47:29 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 7 Feb 2025 09:47:29 +0800
Date: Fri, 7 Feb 2025 09:48:16 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>, Mariel Tinaco
	<Mariel.Tinaco@analog.com>, Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
	<tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, David Lechner
	<dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz Duszynski
	<tomasz.duszynski@octakon.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 17/27] iio: adc: rtq6056: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <Z6VmYH/nt8rZFjvJ@git-send.richtek.com>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-18-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204200250.636721-18-jic23@kernel.org>

On Tue, Feb 04, 2025 at 08:02:39PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

