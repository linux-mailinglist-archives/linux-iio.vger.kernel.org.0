Return-Path: <linux-iio+bounces-27291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C746CCD446E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8534B3008185
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053C235C01;
	Sun, 21 Dec 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAjiaKal"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9421531C8;
	Sun, 21 Dec 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343627; cv=none; b=n2Zid2vx6rQrKqvSCJOuK7DymYVWKMZhX5DjhGANTjssXY4xL1VLGtXroUsLGE25GXrDDX1IXJUXxni3DnSC8K6J4a0VH6mViOf/kH5MRMmTV1BQNoN8tlSDla/0dWYR7E6NPDxxGYr/ICdFGiXlvfwOlP9TJaAEaBef6lWzYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343627; c=relaxed/simple;
	bh=gISvZ7uiRw2DVeZyAbf8mU5/eO1t0LE5VqvXtGRHxNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+zvfETmKtuCIvI+JZhde6xgZxJxygvWNp0D9O5vFXH3jVtq6leBG2d/1B4R5ToQEk4U3xRhBo8mjUgo63mjfLnX6YpXzQnjMszZdpG7gWv5PAoer5Q8hp7c/10ma5PKjqTtNw817RKRLS++S8O3UR5J1AnhI6SX+CrekLn53TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAjiaKal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F811C4CEFB;
	Sun, 21 Dec 2025 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766343626;
	bh=gISvZ7uiRw2DVeZyAbf8mU5/eO1t0LE5VqvXtGRHxNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAjiaKalwmMZ81LniL2x0dAGc2dJJzFJ0TwDrYI+C8vQUmcZIMhH9jexZuXX5c0vh
	 zwCNzIgHBV5ls9zC6qvNIWRAKXYWPXUC+IJ0cVuMopxwWL6DGyVjUkcgRAyzwsisFn
	 SRA2fLrD3Opd6rmEge0GmvWLAoroh6KDES6hknHTiLXPJY8LGPp4xkCeQxM57LWEvF
	 nh0QfbqjNUxxmilMu+mphOeWpELcszEZHP1/4UgUY+RxzUK266Th9vntALhxoSe7dw
	 qTtz4OjEesXBdMKpwxAxBvu9rRDv+TWCo7G8y6eec84sn/piCtv5QzeVPn/ByX2EUv
	 VfHqTuEArmeRQ==
Date: Sun, 21 Dec 2025 19:00:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V8 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20251221190010.2d111e0e@jic23-huawei>
In-Reply-To: <6afcb26f-6f6a-41ef-ac45-976e5e2f17ae@oss.qualcomm.com>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
	<20251127134036.209905-4-jishnu.prakash@oss.qualcomm.com>
	<20251207165349.72f80659@jic23-huawei>
	<6afcb26f-6f6a-41ef-ac45-976e5e2f17ae@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 18:45:32 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 12/7/2025 10:23 PM, Jonathan Cameron wrote:
> > On Thu, 27 Nov 2025 19:10:35 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS.
> >>
> >> One major difference is that the register interface used here is that
> >> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> >> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> >> channels, which may be used for either immediate reads (same functionality
> >> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> >> (same as ADC_TM functionality).
> >>
> >> By convention, we reserve the first channel of the first SDAM for all
> >> immediate reads and use the remaining channels across all SDAMs for
> >> ADC_TM monitoring functionality.
> >>
> >> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> >> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> >> driver.
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
> > Hi Jishnu
> > 
> > Biggest thing I noticed on a fresh review is that you include
> > very few headers.  This only compiles (I think) because of lots
> > of deeply nested includes.  General principle in kernel code is
> > to follow IWYU approach with a few exceptions.  That makes code
> > much less prone to changes deep in the header hierarchy.
> > 
> > You can even use the tooling that exists for clang to give you suggestions
> > though search around for config files (I posted one a long time back)
> > that reduce the noise somewhat.
> > 
> > Jonathan
> > 
> >   
> >> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> >> new file mode 100644
> >> index 000000000000..46bb09424f22
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> >> @@ -0,0 +1,107 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> + *
> >> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> >> + * of type ADC5 Gen3.
> >> + */
> >> +
> >> +#include <linux/bitfield.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> >> +#include <linux/regmap.h>  
> > This seems like very light set of includes.
> > If nothing else should be seeing linux/types.h I think
> > 
> > In general try to follow include what you use principles (loosely as some
> > conventions exit for not including particular headers). 
> >   
> 
> I have a question about this - I'm including some header files in my
> newly added common header file too (include/linux/iio/adc/qcom-adc5-gen3-common.h).
> Do I need to repeat those in the driver files where this header is already
> included?

Yes. If things defined in those headers are used directly in this
c code. 

Just because they are in the header today, doesn't mean they will be 
after some future change and we shouldn't make that sort of future
change harder by requiring people look at all the files that include your
header with those includes.

It's also fairly common for stuff to be needed in the header that isn't needed
directly in the c file (maybe cause it's only needed for a macro). In those
cases no need to include in the c file.

Jonathan


