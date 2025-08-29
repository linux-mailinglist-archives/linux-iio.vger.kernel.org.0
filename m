Return-Path: <linux-iio+bounces-23388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF750B3C0CC
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929EE1C8876F
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BE32A3E4;
	Fri, 29 Aug 2025 16:31:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79D32254F;
	Fri, 29 Aug 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485085; cv=none; b=PbzAMOKvdeFB/qfvRHYigOS7JOtphX6yMFnGuy0mK1LH3dqme9qTeAaYfYWZxXOwLbM+L/Nz3z5mCHwFZSAIAedUZ4OJjLG6hmLdpIQS0Uc3RQRMiap0osvSBAccCWfArpWJJFIQKMKuQqWhRLAUUcRJNBRPcN8ZKnZRlkIzCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485085; c=relaxed/simple;
	bh=KsN9haKZUzNYjRtO2PLxiJ7ZD5EUe6g/Jd3HCROYaEo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mO91mlJnjpC5axE7o+AYeQSDxfwOW6ykT/NS688AKSFh9zKryocmg76CF28dTT/yZJceuIKkYjr+G2120s1PE7wyqrlwCSC1Sv1NBDgnV9QlPMoZZ0tNxJ9Pqyh5DVjmCCDfi2uuI2Ff8JrAQf/fahREN7YZHLd7oBAYTXI0XMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD3b734Tqz6L5vG;
	Sat, 30 Aug 2025 00:27:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 860FA140145;
	Sat, 30 Aug 2025 00:31:19 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 18:31:18 +0200
Date: Fri, 29 Aug 2025 17:31:17 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>, <jic23@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <agross@kernel.org>,
	<andersson@kernel.org>, <lumag@kernel.org>, <konradybcio@kernel.org>,
	<daniel.lezcano@linaro.org>, <sboyd@kernel.org>, <amitk@kernel.org>,
	<thara.gopinath@gmail.com>, <lee@kernel.org>, <rafael@kernel.org>,
	<subbaraman.narayanamurthy@oss.qualcomm.com>,
	<david.collins@oss.qualcomm.com>, <anjelique.melendez@oss.qualcomm.com>,
	<kamal.wadhwa@oss.qualcomm.com>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <devicetree@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<cros-qcom-dts-watchers@chromium.org>, <quic_kotarake@quicinc.com>,
	<neil.armstrong@linaro.org>, <stephan.gerhold@linaro.org>
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <20250829173117.000029e6@huawei.com>
In-Reply-To: <nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
	<20250829-demonic-soft-guppy-512c13@kuoka>
	<zgm2k2osmasdal6anba66pw24a7fiypgwlf3c36kvteshz7uef@wee4had7x54u>
	<8fdc99b6-4ad2-4a08-9dca-6289c8fdddd6@linaro.org>
	<nsyhau4pnn2nbxdf35npwq4gvjiphocrftrwi4seirxqzurww6@6jgyzzmjyg7q>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 12:20:45 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> On Fri, Aug 29, 2025 at 11:11:48AM +0200, Krzysztof Kozlowski wrote:
> > On 29/08/2025 10:09, Dmitry Baryshkov wrote:  
> > > On Fri, Aug 29, 2025 at 09:12:59AM +0200, Krzysztof Kozlowski wrote:  
> > >> On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:  
> > >>>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
> > >>>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> > >>>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
> > >>>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
> > >>>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> > >>>
> > >>>
> > >>> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf  
> > >>
> > >> What's the base commit?
> > >>
> > >> git show 0f4c93f7eb861acab537dbe94441817a270537bf
> > >> fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf  
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250822&id=0f4c93f7eb861acab537dbe94441817a270537bf  
> > 
> > I see:
> > "Notice: this object is not reachable from any branch."
> > 
> > I guess you think this is 20250822?  
> 
> Well, it kinda is. It's a commit by Stephen, it has proper contents,
> etc.  next-20250822 is not a branch, but a tag, that's why you observe
> the warning from gitweb. You can verify it yourself by manually pulling
> the tag from the repo.
> 

Kind of immaterial.  Typically subsystem maintainers want a base of
*-rc1 unless there is a dependency in their tree.

J

