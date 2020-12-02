Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C462CBAE1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 11:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbgLBKq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 05:46:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:17658 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgLBKq2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606905816;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mi/tsaIREtbmjW+UpYfbK8JOpgZQV3mq5I5ijHISdak=;
        b=pbXBLCR+RnEjuQGE64rPa08GcxDQtzzSFszgCka2jhDkeTiY1ycQbe7VtaDMH4Vb3t
        PV2tQ7LbamcaMX3pIz0noRxnMvkhuHbJI9y8OZFjRpT71Ebl+Zagor2kzQ8ygSQDE//b
        zpxIDIqf3FM5wWZE19XY4GItBzCOenB96XqWodVHy7Fr1UIy6hUmLPoOJL6bk9wzzgDi
        S9WgSg+FbUGnq4g6BECk+0eKf1zoJbemRUB9U7K2nfZnNyoNr9KXB6Pozk6+BNzvqJgP
        h4w/7xyIACLqV8kOGLw5h23qxUBJ3YWKuwA+RikfseKVHzVZeTQkhWPhfti4zA6pjI/v
        9fTg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8jxIc/Daoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB2AhZWxM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 11:43:35 +0100 (CET)
Date:   Wed, 2 Dec 2020 11:43:28 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Message-ID: <X8dv0Erz8bZOvlH2@gerhold.net>
References: <20201202101355.87112-1-stephan@gerhold.net>
 <20201202101355.87112-2-stephan@gerhold.net>
 <BL0PR12MB5011BDAEB3374151F522B7F2C4F30@BL0PR12MB5011.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB5011BDAEB3374151F522B7F2C4F30@BL0PR12MB5011.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 02, 2020 at 10:28:12AM +0000, Jean-Baptiste Maneyrol wrote:
> Hello Stephan,
> 
> MPU-6880 is similar to MPU-6500. It should share the same registers map as far as I know.
> 
> Seems good to me. Please also update Kconfig to add MPU6880 in the list for I2C and for SPI.
> 

Great, thanks! Will send a v2 with the Kconfig change.

Stephan
