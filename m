Return-Path: <linux-iio+bounces-24404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2381B99DB2
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D13A6EAC
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBAF2FC874;
	Wed, 24 Sep 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULRDCf0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185464C6C;
	Wed, 24 Sep 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717174; cv=none; b=VK0q65GxcKbdAk+yX3i5bKKEo5QqBYHV3K4EDup8rTzI6xqWRugpLrkQ0sB6vTzvZziEJfrenntZAe38nPxGePvrhwaxNj8QzVFj6HYUqYbDwWnhcvw5upjXtvdeQ4gE3/rqWq2x0BNPjwUXUQ/60GYq7J+U1+xFpIaQBVNJFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717174; c=relaxed/simple;
	bh=z64hXPjSDDrR9mWwhXNbJvORU06KaAiEuX3IuDczyoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC8gXC1pvXjGW9KmJpsh/EYKYdU9EJS9z9dOgY0onFJJt0bJ0899rK59hR2JloKE08/o/5PfKmBOt+gZcqhlqJJrxkvCILteqRRQRw+r/KRO1sFf/X7dxV73R4qi+vfGczYmVB66qWw+tXZL0MZm4+s/r8Dm5AQxQkETwgMgsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULRDCf0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0214CC4CEE7;
	Wed, 24 Sep 2025 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758717173;
	bh=z64hXPjSDDrR9mWwhXNbJvORU06KaAiEuX3IuDczyoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULRDCf0qblHajIl5tMOCqW2QlrTPNPQxs85zLgzDM0altTMvFrpfJiVKa3scmEJ6F
	 rCALDgzahIaRlrKPRDQnFYEuBFYEmZIeu6WvcCI2UepX2/oBj7xUfZrTV4I8bLuMlR
	 tV65w8AVQ1QduJfuEeknS96zdO4DY0YoNMPRa1Cg=
Date: Wed, 24 Sep 2025 14:32:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Message-ID: <2025092451-immortal-synopsis-51fa@gregkh>
References: <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
 <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
 <aMxWzTxvMLsVWbDB@smile.fi.intel.com>
 <2025091925-thirsting-underuse-14ab@gregkh>
 <f16ea5eb-cbda-4788-956b-d41c2af51745@baylibre.com>
 <2025091918-glancing-uptown-7d63@gregkh>
 <8702fd35-945a-4d20-bc37-410c74c70da6@baylibre.com>
 <2025091902-dwelled-calculate-c755@gregkh>
 <x5ot622jqzz67imvswtdacqeeclqaw7my3pj6ne7tureec6ufg@fuzltifrkcae>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <x5ot622jqzz67imvswtdacqeeclqaw7my3pj6ne7tureec6ufg@fuzltifrkcae>

On Sat, Sep 20, 2025 at 06:41:57PM +0200, Uwe Kleine-König wrote:
> On Fri, Sep 19, 2025 at 05:37:03PM +0200, Greg KH wrote:
> > On Fri, Sep 19, 2025 at 10:20:29AM -0500, David Lechner wrote:
> > > Up to now, my (naive) understanding was that the point module namespaces
> > > is to reduce the number of symbols in the global namespace because having
> > > too many symbols there was starting to cause problems. So moving symbols
> > > to another namespace was a "good thing".
> > 
> > Yes, it is a "good thing" overall, but by just making all of your
> > symbols in a namespace, and then including it in the .h file, that does
> > the same exact thing as before (i.e. anyone that includes that .h file
> > puts the symbols into the global namespace with that prefix.)
> 
> I fail to parse the part in parenthesis. The symbols of the pwm
> subsystem are defined in the "PWM" namespace (using `#define
> DEFAULT_SYMBOL_NAMESPACE "PWM"` in drivers/pwm/core.c). In <linux/pwm.h>
> there is a `MODULE_IMPORT_NS("PWM");`, so a consumer (say
> `drivers/regulator/pwm-regulator.c`) only needs
> 
> 	#include <linux/pwm.h>
> 
> to import the "PWM" namespace. So pwm-regulator.c puts the symbols
> into the global namespace with that prefix. What symbols? What prefix?
> 
> The thing that is different is that the pwm functions are in the "PWM"
> namespace, so a module without an import for "PWM" has a smaller pool of
> global symbols and so loading that module is a tad more effective,
> right?
> 
> I agree that for the consumer source it doesn't make a difference if pwm
> is using a namespace or not. I'd count that as an advantage of the
> "import in a header" approach.
> 
> > Ideally, the goal was to be able to easily see in a module, what symbol
> > namespaces they depend on, which requires them to put MODULE_IMPORT_NS()
> > in the module to get access to those symbols.  dmabuf has done this very
> > well, making it obvious to the maintainers of that subsystem that they
> > should be paying attention to those users.
> 
> For me as pwm maintainer it doesn't matter much if I pay attention to
> `MODULE_IMPORT_NS("PWM");` or `#include <linux/pwm.h>`.

I think this is the primary thing here.  It's easier for some
maintainers and reviewers to notice the MODULE_IMPORT_NS() thing than a
simple include line.  Especially as includes are often hidden in other
include files.

So sure, as a maintainer, you are free to do things this way, it's just
not really what we thought about when namespaces were first created.  We
assumed that an explict MODULE_INPORT_NS() was what would be used, not
worked around :)

> > For other "tiny" subsystems, it just slots away their symbols so that no
> > one else should ever be using them, and it makes it blindingly obvious
> > if they do.  For example, the usb-storage symbols, anyone that does:
> > 	MODULE_IMPORT_NS("USB_STORAGE");
> > had better be living in drivers/usb/storage/ otherwise I need to have a
> > word with those offenders :)
> 
> All symbols in the "USB_STORAGE" namespace (apart from
> `fill_inquiry_response`) start with `usb_stor_`. If you grep for that
> string you find all the (probably illegitimate) users of the usb-storage
> symbols, but also those that define their own symbols with that prefix.
> 
> Do you actually look out for such offenders, i.e. have a lei mailbox
> with `MODULE_IMPORT_NS("USB_STORAGE")` as search string or a cron job
> grepping your tree for that?

Some maintainers do just this, yes.  I think the dmabuf maintainers do
as an example.

> > So it's a way of "tidying" up things, and to make things more explicit
> > than just having to rely on searching a tree and looking for .h include
> > usage. 
> 
> For some reason in your eyes grepping for MODULE_IMPORT_NS is superior
> to grepping for an #include. Can you explain that?

#include files are often included in other include files, and can easily
be "hidden" in the chain of what is needed by what .c file.

That's it, nothing major here, if you want to use namespaces this way,
that's fine, just feels kind of counter-productive :)

thanks,

greg k-h

