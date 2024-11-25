Return-Path: <linux-iio+bounces-12648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A019D8C5E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 19:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF75916A81E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E01B87FA;
	Mon, 25 Nov 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAg7xhid"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE11B414E;
	Mon, 25 Nov 2024 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560185; cv=none; b=uoqvDcDu00oY4hufVlCAg7vpMfUHnXm1vFy6DnleI0RUVBYQ1UYgQ3maes+JldJTUkvXa2QFL+LHbMTWM6ZcRG2oUPbKSscy8l3LLIDEppiF0vJmg66S2JQ67QQxVRBqUSaH66wG34kIga0JfltcMwwwYaTFRDVNS0eoxuqFxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560185; c=relaxed/simple;
	bh=+NhohOKeeJop2jxV/1j/MYLQnUGaeIOGmTk1PDvMxNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2y/IRfPUU1G9b2P1nXgQfzI5o+QQRe2lD8BHqZnxre/nsxlZVqA2IJ/JSvP3O1CVAo4uv4RtrIVnH/EQn33UJLnpLyAQt3ykBT0Gwkaiyx+d/apQDA5rYILfhuSW2rt8jxc0uturqZ44anA8tzPUidCEikOJTYx/odDUh8zEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAg7xhid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A26C4CECE;
	Mon, 25 Nov 2024 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732560184;
	bh=+NhohOKeeJop2jxV/1j/MYLQnUGaeIOGmTk1PDvMxNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAg7xhid0xYQh2ML5Jg3kSOKPApbYrUJofs/fM9rDV2XtdcagV3UhEC0RMcqmwWI+
	 Q4+TWm5/TC6yZgmOkFcL7/8PW4OmzDA3+3nFHh0DKTvOB5QD02z7EJkYjZqaIgOINa
	 E+4fbOEkh08BNSWFyPldtnw8ysryeNSPVDK9YgrrR0PBXOCJxi0XQKO5FAVVGzK1ZA
	 NjYmcXL5G3sL/2cCA39rLc2UahvDBgFlYbvlW9mTlZd9NI1aczc3QqtogtoZHE+kor
	 rthiW+wdTHMOdcNaqYUJ+WYnhMbxxJFl8BPW6J5bVKzCyVLViRZykJUWTYtdPZuKye
	 YBv/g6fA7jMTQ==
Date: Mon, 25 Nov 2024 18:43:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <20241125-scarecrow-slouchy-5e8e5bc0c17b@spud>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
 <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
 <Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>
 <ZzuGtvdrD6D06rEp@debian-BULLSEYE-live-builder-AMD64>
 <20241124131147.0d616f82@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YzOZhQR+d8nuzzbO"
Content-Disposition: inline
In-Reply-To: <20241124131147.0d616f82@jic23-huawei>


--YzOZhQR+d8nuzzbO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 24, 2024 at 01:11:47PM +0000, Jonathan Cameron wrote:
> Usually what DT maintainers are looking for is a clear statement of how
> the devices are different.

Ye, tell us rather than make us open the datasheets or have to ask
questions to figure out whether or not what you've got is correct.

--YzOZhQR+d8nuzzbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0TFMwAKCRB4tDGHoIJi
0vmjAP9nuLe7lsgNov37uozzreaO32Ax6UE1CjZUelSR2wYebAEArL1lbsnAOwPK
WcMruNMfuYgPc6XFBMLZ4U5TQzlRrAA=
=Fnxm
-----END PGP SIGNATURE-----

--YzOZhQR+d8nuzzbO--

