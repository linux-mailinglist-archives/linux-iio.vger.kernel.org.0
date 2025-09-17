Return-Path: <linux-iio+bounces-24223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F049EB81AB1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0A47A220D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3499301715;
	Wed, 17 Sep 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi67W+xl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18C18D656;
	Wed, 17 Sep 2025 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138236; cv=none; b=NzgoMZyCPgma9lpgcsB8TOCALbmtwAnZkI1EBW304wPvhLU5u3PZq6inQuxWZ9RRlonL+zu+eGPRi3JH0zV3a66+NzzVcNQyi4Bl3snNsT+Kh7budw53C838g5m4DG45T92gF5dJm4ukAXCoXrW7wF9fDueFZtWgjjWgn9cH8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138236; c=relaxed/simple;
	bh=q+Lt8bH7T373kamJB5/tW5TmCsjbKI0EIvvyC2SNLBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwrg6bFz9xrsBR146YJPFf6xEGq9r7E9o4TZg9uxwL3+qWN28NbiXN5qz0SVCmOLBeAxE9fPs5cJcpJaRZhT41Z88aL/pyPVUi3fKTK0Z6mxUMuswXdPCYbBkWqcP1QJYtm4/VILwDftDfjBe1vfwaBaol/OIb0cGraLydpRnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi67W+xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C9AC4CEE7;
	Wed, 17 Sep 2025 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758138235;
	bh=q+Lt8bH7T373kamJB5/tW5TmCsjbKI0EIvvyC2SNLBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yi67W+xlyLhhvg7XND+78Cx7G7AW4F9jGoY5/Kd9uVeWBMKDBf1iMzIwktyPSbibR
	 hmEE8+7Rg/Dn7EjkUIl+9dVmyYg2PADd3MlugSPmwTk5IiMx2zUauAn2QNBwrMnEV+
	 mZXO3Qv6vW9zWmSNxlhP8G7Nrb6uyL9iUo2zdKzUTK1rBt/QZKET7df+/rEPOtfSTZ
	 CBxM88mVDHzCM2/UdCBbITHLnZuqYsCy3OnChqVUiJssJpaqSE/IpEAyRWXM/NQlTw
	 Tkwl/YwctXk2/ACsm271DrynM5sZ8sFl/bBHmyked2o3HryaxSYO3Px0QzqXUfyo1c
	 RKF90lq6nfOZw==
Date: Wed, 17 Sep 2025 14:43:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	agross@kernel.org, lumag@kernel.org, konradybcio@kernel.org, 
	daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	lee@kernel.org, rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, 
	kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <uvgeuxf7cpnlypif35lvzatdkwrnxynhvf43qw2nc2bvt3zcf3@75kkwp3raqfm>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250829-demonic-soft-guppy-512c13@kuoka>
 <zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
 <8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
 <nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
 <20250829173117.000029e6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829173117.000029e6@huawei.com>

On Fri, Aug 29, 2025 at 05:31:17PM +0100, Jonathan Cameron wrote:
> On Fri, 29 Aug 2025 12:20:45 +0300
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Fri, Aug 29, 2025 at 11:11:48AM +0200, Krzysztof Kozlowski wrote:
> > > On 29/08/2025 10:09, Dmitry Baryshkov wrote:  
> > > > On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:  
> > > >> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:  
> > > >>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > > >>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> > > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> > > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> > > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> > > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> > > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> > > >>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> > > >>>
> > > >>>
> > > >>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf  
> > > >>
> > > >> What's the base commit?
> > > >>
> > > >> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> > > >> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf  
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf  
> > > 
> > > I see:
> > > "Notice: this object is not reachable from any branch."
> > > 
> > > I guess you think this is 20250822?  
> > 
> > Well, it kinda is. It's a commit by Stephen, it has proper contents,
> > etc.  next-20250822 is not a branch, but a tag, that's why you observe
> > the warning from gitweb. You can verify it yourself by manually pulling
> > the tag from the repo.
> > 
> 
> Kind of immaterial.  Typically subsystem maintainers want a base of
> *-rc1 unless there is a dependency in their tree.
> 

Basing the work on -rc1 is nice, but unless I'm missing something, patch
1 depend on changes that only exists in your -next branch and changes
that only exists in my (the qcom/dts) -next branch.

So, it seems that this can only be merged into next-20250822, not into
any actual maintainer's branch.


In the current form, the only sensible way I see to merge this is to get
a version freshly rebased on v6.18-rc1 (before we pile up any other
conflicts), we merge patch 1 into a immutable branch and then you take
the rest of the patches on top of this in your tree. Does this sound
reasonable? I'm open for suggestions...

Regards,
Bjorn

