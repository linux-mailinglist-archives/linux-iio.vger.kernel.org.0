Return-Path: <linux-iio+bounces-24294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6975B8A3AC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F9A5A2036
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10C314B95;
	Fri, 19 Sep 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTfvrNp2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0266314B64;
	Fri, 19 Sep 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294819; cv=none; b=B+/6EkShYm2hbDSkTa24HUQLmSi0EUxuin0O4nmiBfpZHPn3kFRneO3k5HQw2ihRwC8BROTUESZc4pAuytNIRVLU6ueDZbxkSXA+BGGisHqJxTtxyU0zIrBYBaM4zXKCI1fp7WitzsUDj54avkswEo66EMyGX6DN3T94mKRZxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294819; c=relaxed/simple;
	bh=3XR30WLTOOqaLDbQmwjt+NVp8deJQN0osgjpiVmNnyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJgTJtYnnDk1rcwCcwFEsGkltQfc189/C6EagzIzDcYwtabEgaZ6czjDfPdbpGd1RYmgu2D/iVXBk19WVfmbhN5d+LTq61ATvbsQASYfL8BZGjYMcs51V4VmUOp5D01XMs+1tu8tEDbuJPiud1foAiTvAsNXZ5BCekzPch1k5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTfvrNp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2F5C4CEF0;
	Fri, 19 Sep 2025 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758294818;
	bh=3XR30WLTOOqaLDbQmwjt+NVp8deJQN0osgjpiVmNnyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xTfvrNp2EpA0VDTIMQAhvZAqkMQJpCWmHPPKwJP0RoL1Ho+v2yhtr3ErFgKCdGXej
	 ophms+3Jqw3/kW2jkY3g9luVTt290bFLA004KoV7R4SVXiabJOI+46q2DYJ5f8M4b0
	 lLdBK12vZX4leiABXom7gT+SiSHdaB+PFVsTk3eo=
Date: Fri, 19 Sep 2025 17:13:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <2025091918-glancing-uptown-7d63@gregkh>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
 <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>

On Fri, Sep 19, 2025 at 10:05:28AM -0500, David Lechner wrote:
> On 9/19/25 8:59 AM, Greg KH wrote:
> > On Thu, Sep 18, 2025 at 10:00:29PM +0300, Andy Shevchenko wrote:
> >> I,o.w. I principally disagree on putting MODULE_IMPORT_NS() into the header
> >> file.
> > 
> > Yes, please never do that, it defeats the purpose of module namespaces
> > completly.  If you don't want to have module namespaces, don't use them
> > for your subsytem.  Don't use them and then make them moot by putting
> > MODULE_IMPORT_NS() in the .h file for the symbols as that's pointless.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Could someone suggest some additional explanation to add to
> Documentation/core-api/symbol-namespaces.rst to explain the
> reasoning behind this?
> 
> Right now, the only part of that document that say _why_ we have
> module namespces says:
> 
> 	That is useful for documentation purposes (think of the
> 	SUBSYSTEM_DEBUG namespace) as well as for limiting the
> 	availability of a set of symbols for use in other parts
> 	of the kernel.
> 
> So I don't see the connection between this explanation and and:
> 
> 	[Putting MODULE_IMPORT_NS() into the header] defeats
> 	the purpose of module namespaces completely.
> 
> I am guilty of putting it in a header, so if I need to fix that
> I would like to actually understand why first. Andy has mentioned
> something about potential abuses, but without any example, I haven't
> been able to understand what this would actually actually look like.
> Or maybe there is some other reason that Greg is thinking of that
> hasn't been mentioned yet?

Let me turn it around, _why_ would you want your exports in a namespace
at all if you just are putting a MODULE_IMPORT_NS() in the .h file at
the same time?  What is this giving you at all compared to just a normal
MODULE_EXPORT() marking for your exports?

I know what it gives me when I don't put it in a .h file, but I think
that might be different from what you are thinking here :)

thanks,

greg k-h

