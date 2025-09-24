Return-Path: <linux-iio+bounces-24410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC65B9A0A5
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF644175249
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407C02EC54A;
	Wed, 24 Sep 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTlJxizQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E394143C69;
	Wed, 24 Sep 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720818; cv=none; b=JJ5kNm1ygmDVU+BE+cIEfNBtG0rS8xlRw0Mv2uY/dXdupy/mnru7o5U84AQUYsoJBb6wqFxTdAV99T6T7lJLi2ixzDoVT/hxHhcWerGwpgGFnTO4XoVgfb/hTERXf5msbq69WVzdWp772jI9t0fh0HIQv4s9cXyHyg5Y+EZZySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720818; c=relaxed/simple;
	bh=zEiOrr86mc3pXU3ZmU44YuztailX5N3hOgOdNmn8mW0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hlLgzpVLXwBGZg5zNhjkeryXEWEIAbRwmpBQtXrtSQMtArO/SJxNKx9AeFesYX2nSg9ImhapMW00JEJdFHowoJ4hF8+68ssGxedjcrvTxyIdlVDAqOzBmOMKRaVEeVKSaK1+9eYL1xnWt6snlQNS8xXO3HyUVsINnX20E7KrI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTlJxizQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758720816; x=1790256816;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zEiOrr86mc3pXU3ZmU44YuztailX5N3hOgOdNmn8mW0=;
  b=iTlJxizQ59ILKETEgchzNK14bqoBrL0VmJ/P4Re4yM8+kO7mws4BmtKa
   C+0bLsfjxLJpwRfLVpta8ZyBQm4sno0gx2lhoMkj1JpFZkqSgNCcm4EuR
   SfeQpKwHURH3MbXUn3AG6NYdmfhb+hZttFq120s32NcJU8E2izdaEsw0y
   /VPtsCqzclziZM3eNvKifCNy7SqcgFD8N0fBfPG/KuhNaXEOABGzeXM/Y
   Gv98FYSZ0U4a3bcEYF+VqoE/11e3hdzbGnAUn4M5Z3MWLBeBYaLngTzcp
   RQGu+ErJnbNdkHNCu900tmi3BxyLoMJJVoZcrl9cR/WemwV244P5XiwBL
   g==;
X-CSE-ConnectionGUID: zsJcTX4WRZ2xB9DErCfExw==
X-CSE-MsgGUID: meH+SaTFRsOHae+J4cey/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71638539"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71638539"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:33:35 -0700
X-CSE-ConnectionGUID: Z5DrPEzbTPedJnUisz7pWw==
X-CSE-MsgGUID: 0PZf0EROTPShTLfC8u1ctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177806509"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:33:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Sep 2025 16:33:30 +0300 (EEST)
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
cc: linux-iio@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update Intel Quadrature Encoder Peripheral
 maintainer
In-Reply-To: <20250924131947.70898-1-jarkko.nikula@linux.intel.com>
Message-ID: <70ef3a26-d70b-3506-3bae-6c87c39f3d22@linux.intel.com>
References: <20250924131947.70898-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1129478150-1758720810=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1129478150-1758720810=:938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 24 Sep 2025, Jarkko Nikula wrote:

> My address is going to bounce soon and Ilpo agreed to be a new
> maintainer.
>=20
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9fc91b4ce4f..8fc8426d88c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12609,7 +12609,7 @@ S:=09Orphan
>  F:=09drivers/ptp/ptp_dfl_tod.c
> =20
>  INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
> -M:=09Jarkko Nikula <jarkko.nikula@linux.intel.com>
> +M:=09Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>  L:=09linux-iio@vger.kernel.org
>  F:=09drivers/counter/intel-qep.c
> =20
>=20
--8323328-1129478150-1758720810=:938--

