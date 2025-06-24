Return-Path: <linux-iio+bounces-20933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C571AE59C5
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DA77AE5A7
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C231DB148;
	Tue, 24 Jun 2025 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0920kgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0279256D;
	Tue, 24 Jun 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731768; cv=none; b=srPCY39EYHZxAlnZ5N78PkZURfmnxNuBbc1hGQxSlngVMW1pdF3dWUAmU5fLT94CEJyzYaJY8yqYT8Jsro0Tk2DZdTPr02fbO5kmp2r9hllGvw35xOleUMvXE25bqZFfglKcyuZ6WzZQrNOLeswCLUf9yiC+UYfBFmBIsSzve90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731768; c=relaxed/simple;
	bh=Uq5KS+DF6ePdWsZM3dnaMWOWOkcvyotI6KJ4U3VBdfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3pMAb8o1UegBpWn1jnT/TzMq3fcPKrUxwCvh6Syt6+qjA7lSu3+qwlZIzq6Oib8MFmuHOX7tw0S87IbhUYnb9SzeYza2MKBrKhsbinRVOiyrIJFzY/9k8F6tm6HLQdoYxGrKU1Trt+IMy8VkLfAwiRV3YsOE58rsCzxxKsKxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0920kgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82133C4CEEA;
	Tue, 24 Jun 2025 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750731766;
	bh=Uq5KS+DF6ePdWsZM3dnaMWOWOkcvyotI6KJ4U3VBdfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0920kgu8PadzIyF6TRuAgF3WaG07pre7AszcE9w6rx0e+c4Ltaa2e5EnGaIVlpFR
	 MHlefF0Ia0UfHA3D2TuaWPSXpn7Dt/H49OFXlw9cxKJjbLMaSgGO8VDOj9sI1XQRo/
	 VOBZDihIFM1fVqMk4kQHo6V2In5xS5kYHzFIZz7ufXsWC8vm/Oe7PxUHAjFWxzYuvZ
	 9yuK1UUN1wTZ8fKiJpBqND6+VHfmT+3E8PSweLN39qXv3DZgXzN0hixDJV9FDB9s7K
	 NsuJnHM0fgWRlt+uMd89scrlyK4mhJjiyae9sHmzkzWmWZ1cGLBzcw+Y+Nx5ULdlfd
	 tlPRID6XJ8qJQ==
Date: Tue, 24 Jun 2025 02:22:43 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] iio: cros_ec_activity: Fix function casting error
Message-ID: <aFoL86kzENM2jMqi@google.com>
References: <20250623185153.222714-1-gwendal@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623185153.222714-1-gwendal@google.com>

On Mon, Jun 23, 2025 at 11:51:52AM -0700, Gwendal Grignou wrote:
> .write_event_configwrite_event_config expects |state| to be an int not a
> bool:

No, `state` is a bool since commit b4b42f28a0df
("iio: fix write_event_config signature").


