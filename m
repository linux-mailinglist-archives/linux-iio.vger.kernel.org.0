Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0F193F6E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZNHO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 09:07:14 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:44740 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgCZNHO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Mar 2020 09:07:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B7481412CA;
        Thu, 26 Mar 2020 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1585228030; x=1587042431; bh=PPxO9THUKW0Y8T07g9JhE0Tkh
        jNrIcxaWYJ3+PFeK5w=; b=h6R43otw6be3mXczTf8IOGCNMEuy21IzXZqe1HZ3O
        6lz0aBzMrmwgcn3w+xD6eqrEFHsfPwL8dJBG+a7LnmZoy1/yKxbOOpJmdYzu+hGR
        mejGXqHpFdADFiq9hGExVdMMyyETAPnX+Cu6Ye5PYgJ8vBlYlUOJfqIKg3BaJpMC
        C0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HRUIpFGQUQhE; Thu, 26 Mar 2020 16:07:10 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4272B412C9;
        Thu, 26 Mar 2020 16:07:10 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.118) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 26 Mar 2020 16:07:10 +0300
Message-ID: <746c7b3ccbd013edba84a51fc0a99bb11e5f9c26.camel@yadro.com>
Subject: Re: [PATCH v2 0/2] iio: proximity: driver for vcnl3020
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Mar 2020 16:06:37 +0300
In-Reply-To: <20200325151211.19949-1-i.mikhaylov@yadro.com>
References: <20200325151211.19949-1-i.mikhaylov@yadro.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.2.118]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-03-25 at 18:12 +0300, Ivan Mikhaylov wrote:
> Add proximity sensor driver for Vishay vcnl3020. Only on-demand
> measurement is supported for now.
> 
> Ivan Mikhaylov (2):
>   iio: proximity: provide device tree binding document
>   iio: proximity: Add driver support for vcnl3020 proximity sensor
> 
>  .../bindings/iio/proximity/vcnl3020.yaml      |  47 ++++
>  drivers/iio/proximity/Kconfig                 |  10 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/vcnl3020.c              | 242 ++++++++++++++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
>  create mode 100644 drivers/iio/proximity/vcnl3020.c
> 

Changes from v1:
   1. using regmap interface instead of i2c_smbus_* calls.
   2. switch from probe to probe_new.
   3. s32/int32_t -> int


