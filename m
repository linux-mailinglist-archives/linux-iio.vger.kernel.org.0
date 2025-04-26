Return-Path: <linux-iio+bounces-18707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC881A9DBDC
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F00B172080
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BE25C702;
	Sat, 26 Apr 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0ETBDea"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F779CF;
	Sat, 26 Apr 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681771; cv=none; b=DBz9hbDzRM1kSAbsptcvnc+QhKxJjXVgGAMKelFY6q33oDRNXgnpeIZJrE3/VZ4XvrZOCXv0YpH5Y86IoPzfml2gOO9PqE2LKNAQV+CQAC75yRHIhtM9d1m8JGBiVgbk2gl6lriKfoNAMDDyK1kKhYMlUPvqLBe1oHmgoJhuIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681771; c=relaxed/simple;
	bh=cVOtTGxDMOCbcT/KScH5huOrC/c4Bg6vugd/Zwe/gYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zjg3Xz+9cV5hUGNewik4QO/ck9jqzCA3iWOuu/YpCB8fB0KoTQUFRKQdo7oaB9vo9ikVYu1BTq5C9G82aw4GszW+aClbhouwjALD9V/wdqk8YZI0DIbreYLzYa4ezZhmIcF+a/oQPqxPcht5uivNT2+XehhxTZtdhUvyqWvOf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0ETBDea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0A7C4CEE2;
	Sat, 26 Apr 2025 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681770;
	bh=cVOtTGxDMOCbcT/KScH5huOrC/c4Bg6vugd/Zwe/gYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e0ETBDeabPje2Fni+Lc2L3pyGWGJNNlVwlieZ4alC5kq//qYATPYuD2Fqsef7BVDV
	 8HHmBAseSqm0+QwtujhR8vJhAUgMEJ/RC9IDeh/G5jYJkroT6RAq/QElAgmEvN3wKe
	 71M8cMy6v+tkxIruQcaEvO4bYtuV5NHwOPZhyI5AbxMRvP8h9clqqDXelJwjYUdsQr
	 r69JNvQ+mL6bz7tNalxMU1/yXd33dXC1XnuMkYOHXKXxHyf0WopmLwA77enscpeRyy
	 7X/LkNGWoFKdEyARBJS6anWQvN8oXg4fhx/gcwUI8KXCPHNi83a7aPKucM+sPxNp4w
	 2nrZQOH5MvgAg==
Date: Sat, 26 Apr 2025 16:35:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>, devicetree@vger.kernel.org, Lukas Rauber
 <lukas.rauber@janitza.de>
Subject: Re: [PATCH 0/3] MCP3911 fixes
Message-ID: <20250426163556.53310ed2@jic23-huawei>
In-Reply-To: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:46:48 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This series contain two fixes for the MCP3911 driver:
> - Add support for reset signal
> - Fix wrong mapping for the coversion result registers
> 
> The register map for the conversion result registers of the MCP3911
> differs from the other variants so make sure we read from the right
> register by introducing device-dependent .read_raw() callbacks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
I took a quick look as well. Nothing to add to Andy's detailed review
so I'll wait for v2.

