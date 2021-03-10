Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AA333B4A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhCJLYo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 06:24:44 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:61541 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhCJLYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 06:24:17 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 06:24:16 EST
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 91C4DA1820;
        Wed, 10 Mar 2021 12:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=upyph0mD533C
        Y6YiXd33LgOwWoBbDT7ww7/3l9ldIhw=; b=x6trUXuix8nRLTknbDNPF3W/LMep
        gCDJf98BJpEqs9OFdJlwaFV+bSgWizAAQMeazcNTEeV9I4srSzxXvp2czrBegjgX
        ezUD5iP61WhOu7pfD98sMW4ulQjEI1XGZZ1iHLpDPDyHBI5bta4vpwJXyEd7B08z
        982T+XILi7A5YN7iALhBhF9/rI2CNnC25P1nMNULqeb2Xk+eSAMgRDjEoOpMBLTJ
        YRu3r3CdFBbeDW1pl34z0U10PRCPVTEQjDQZWmOzZyWWxbI+eFWrmVtOsXkTGhPe
        e/eFNPTiBvwmT998KWWr2R2t5slRuDLy5A9i3SwyLzhmh17+bsVuITcAjA==
To:     Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <cristian.marussi@arm.com>, <sudeep.holla@arm.com>,
        <egranata@google.com>, <mikhail.golubev@opensynergy.com>,
        <Igor.Skalkin@opensynergy.com>, <ankitarora@google.com>,
        <gurunagarajan@google.com>, kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210309231259.78050-1-jbhayana@google.com>
 <20210309231259.78050-2-jbhayana@google.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <0b9483ca-6f61-cc13-34e6-7f8c31c4c626@opensynergy.com>
Date:   Wed, 10 Mar 2021 12:15:58 +0100
MIME-Version: 1.0
In-Reply-To: <20210309231259.78050-2-jbhayana@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10.03.21 00:12, Jyoti Bhayana wrote:
> This change provides ARM SCMI Protocol based IIO device.
> This driver provides support for Accelerometer and Gyroscope using
> SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification
> 

[snip]

> +
> +static int scmi_iio_get_chan_modifier(const char *name,
> +				      enum iio_modifier *modifier)
> +{
> +	char *pch, mod;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	pch = strrchr(name, '_');
> +	if (!pch)
> +		return -EINVAL;
> +
> +	mod = *(pch + 1);
> +	switch (mod) {
> +	case 'X':
> +		*modifier = IIO_MOD_X;
> +		return 0;
> +	case 'Y':
> +		*modifier = IIO_MOD_Y;
> +		return 0;
> +	case 'Z':
> +		*modifier = IIO_MOD_Z;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

Hi Jyoti,

could you still change the above code to also accept lower case 'x',
'y', 'z'?

Supporting lower case as well would establish compatibility with the
lower case naming conventions used for IIO channels. By this change,
channels could be forwarded without name changes (as long as they fit
into the name field). I'm sorry to notice this only now.

Best regards,

Peter

