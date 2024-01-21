Return-Path: <linux-iio+bounces-1808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510983572D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEF91C20BAC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008B381CF;
	Sun, 21 Jan 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtZzmeDe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA79364A4;
	Sun, 21 Jan 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705859861; cv=none; b=VL7g91kniLNYgoekWG0YLZ/dpVaAoXIK5b3b4mcpfo9Qyt0R6Zuadlk7Qhx59DdggcuRTDLGhictWrM3do4ioqwPuosjDl8H6sgXmF+XZ3+FYciL4OjvTmXRki1QWW2FTFGn4XU6ORKv8g3n4ddgHQbrxfS1sD0kzbXmyUuB1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705859861; c=relaxed/simple;
	bh=2Gk/6aho2UWCePRtTzragiBBNZ819HZsmB5N6RusdSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/PJnYqwhT7bnGO2fTZcY/sSdILGPPmdPNXVxjqj2wfrOj9mptzpNzGJTs4wo7chqpj4rapJK3p7v4VirHeIkv3RLiwBo0PnUv/v+HIF+ACKIA8qvtl7BKaS1d3ndOyww2KuYMwkDcdmeTlLVLzV9Z7Q54Z0srUo7rCVKstcxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtZzmeDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7BCC433C7;
	Sun, 21 Jan 2024 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705859860;
	bh=2Gk/6aho2UWCePRtTzragiBBNZ819HZsmB5N6RusdSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dtZzmeDemxOuR6Ab/egnsx7w2uPYe0LHQZCsTR9Y/3fzFUEH+H04vHJKj9F2YR/w9
	 dNKLl3XmVbzleaQZs1sV2RjKypiLRoK4qv7bLagwEo94vADKoSHRZfvXa3t7IDr0AN
	 UG1+eS/9kx7PEoziZ56z0jhSXUyml0oehm4cW8TVy1ffDwX2jI04GEchjWqQOFu23o
	 375fUO0xTXljsRvVQsEZU63LJLj1CoMaywrYV8q/6YHoxehs5g3j8MRwNi7nNDN02u
	 kG4IUxzomJTkBhAIYbVJ38fFwA2xBtAiBls2yexSgF2QmulgFARSfHHxvx6nqSGc70
	 ImlkR4AkVRPyg==
Date: Sun, 21 Jan 2024 17:57:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Rob
 Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/8] iio: add new backend framework
Message-ID: <20240121175724.76ff9be3@jic23-huawei>
In-Reply-To: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 17:00:46 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:


> Changes in v6:
>  - Patch 2
>   * Add '#io-backends-cells' property to the example dts.
>  - Patch 6
>   * Improve comment on struct iio_backend_buffer_pair;
>   * Be consistent with dots in kernel-docs. So dots only exist now in
>     description and return. Also be consistent on device managed APIs
>     subject and @dev description;
>   * Added devm_iio_backend_enable() and hence (and for now)
>     iio_backend_disable is static;
>   * Fixed __devm_iio_backend_get_from_fwnode_lookup() kernel-doc;
>   * Improved english in devm_iio_backend_register() comment;
>   * Don't make private data mandatory;
>  - Patch 7
>   * Use local ad9467_chip_info *info variable;
>   * Improve error handling for optional devm_iio_backend_get();
>   * Make use of devm_iio_backend_enable().
>  - Patch 8
>   * Also change string format in version error path.
Hi Nuno,

Other than wanting a few acks (one for 2nd DT patch with the fix and one
for the device link changes) this looks good to me.

Ideally of course I'd like to see the second user if that happens to be
available in the first few weeks of this cycle, but I don't propose to hold
this indefinitely to wait for additional users as the framework seems logical
and it's all in kernel anyway so we can probably change whatever is needed
later without too much trouble.

Jonathan

> 

