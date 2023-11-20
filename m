Return-Path: <linux-iio+bounces-181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9337F1203
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D1D282633
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B3D14AB3;
	Mon, 20 Nov 2023 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiqgaJ2m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE4190;
	Mon, 20 Nov 2023 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479874; x=1732015874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M5VyfO4HyHA+7dmKhfXxCvmtDyHikTHOa2LFJQGtoFw=;
  b=LiqgaJ2mh9t0Z9Y1moEBpuc1q+0/L2qhQX0GMcI5D1EBWMBL9U3/K+xy
   yg+MGLhXGsJ2B5Rjtp2msbuIRyA7pfD/i8NSVxk9EX1eb/uQriOPEaZ+2
   xcc8jsLLFeb89yWXgVei6n/kAt0K8dtGXdZ2PintVfdPNdiM1ByOZjRdz
   utLgntNmXSO0R/hMMDSkqyzaHN0IM2FnL//zhOh7aHI5NpHI/cfnhRR1q
   bc0KANT5sshzoGg4WUKc7/0/C6QBW3LdX2Zast+cZ3CPvbym0S7RP8WWO
   oL4SQAmOQxbhBQFs8N5wRloDlELdfKPfe+PKOJMSUoYVE92BJmZWSxu6n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458097875"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458097875"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="910079573"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="910079573"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:31:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r52UZ-0000000FXEw-1BiL;
	Mon, 20 Nov 2023 13:31:03 +0200
Date: Mon, 20 Nov 2023 13:31:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, daniel.lezcano@linaro.org,
	dmitry.baryshkov@linaro.org, linus.walleij@linaro.org,
	linux-arm-msm@vger.kernel.org, quic_subbaram@quicinc.com,
	quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
	quic_kamalw@quicinc.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
	lars@metafoo.de, luca@z3ntu.xyz, linux-iio@vger.kernel.org,
	lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, cros-qcom-dts-watchers@chromium.org,
	sboyd@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm-owner@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH V2 0/3] iio: adc: Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <ZVtDdySmDUmgUDlm@smile.fi.intel.com>
References: <20231116032530.753192-1-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116032530.753192-1-quic_jprakash@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 16, 2023 at 08:55:27AM +0530, Jishnu Prakash wrote:
> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. The major difference is
> that the register interface used here is that of an SDAM present on
> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> be used for either immediate reads (same functionality as previous PMIC5 and
> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> combined into the same driver.
> 
> Patches 1 adds bindings for ADC5 Gen3 peripheral.
> 
> Patches 2 adds driver support for ADC5 Gen3.
> 
> Patch 3 is a cleanup, to move the QCOM ADC dt-bindings files from
> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> specifically for ADC devices. It also fixes all compilation errors
> with this change in driver and devicetree files and similar errors
> in documentation for dtbinding check.

Something wrong with the email chaining.
Please be sure you are using --thread when preparing emails.

-- 
With Best Regards,
Andy Shevchenko



