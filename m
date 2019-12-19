Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7C125A52
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 05:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLSEbn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 23:31:43 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17172 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfLSEbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 23:31:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576729890; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UyDCt+TvGViy7M6vv40aTV3DcycbcgMO2OWiTSG7NUeiehLJv9/JSAa5S1i40OK55uq2f/TsPjOVashtWPHxXdGQ0pztDaG3G84LharH21Cs1JbcT0vrWcZ2A3EO52cWlfp16OUl9WiJdZpqs7NkVAHH0yOno9KeDBLomEA9pvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576729890; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QhLda09z8A4MXJoGFxR1p93Bzx5xIlPXXi0mEtq581o=; 
        b=VvgYcZ9Ysy57NfRSLXhp44RHpDCdmm0X8XfU0xHoAK8FYI+0Coj6GEHY24+WESTt8p3FjMF8eYFCvMe4JJ/+GCOto/3jfmDw1tZnGa+vv2qhMXQZCnCxzK0A///PxTaDnJOPY2W/H/d4MN8b8804HbqkDMjvkJNDG7MKEMGClE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576729888928382.37734837613027; Wed, 18 Dec 2019 20:31:28 -0800 (PST)
Date:   Thu, 19 Dec 2019 04:15:58 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
Message-ID: <20191219041558.GA23704@nessie>
References: <20191219041039.23396-1-dan@dlrobertson.com>
 <20191219041039.23396-3-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219041039.23396-3-dan@dlrobertson.com>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 04:10:38AM +0000, Dan Robertson wrote:
> ...
>  
> +BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
> +M:	Dan Robertson <dan@dlrobertson.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/accel/bma400*
> +F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> +

I mixed up the Status tag. This should be S: Maintained. Will fix in v8.

Cheers,

 - Dan

