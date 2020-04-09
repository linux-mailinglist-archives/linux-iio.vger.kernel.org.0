Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCD1A33CA
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDIMJZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 08:09:25 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:27808 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMJY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 08:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586434163;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tjOZH6FExE9KhwrfoaOyM6Z0E9wUP3d5Inw9Ja9C7p4=;
        b=W9SCLWkMxd3FSuJ/aiB+h+M1v9nnFpXBw76FqikYWV1Oe5yUEh/DvinECLQdqknikd
        AmUmoeR/DpQIzENEX9psrm/7hFYDCPmZ37EjZDMZfejWl4H73lg48Mu4bllO3sVWuyBd
        RGNK+P59nFfT9i+wIDx04EjvF+ZDR35nmlK+M+bgodmQ+L0zoQjCfu2vlqs2BzoneiJe
        kQjV0vyJ1GIyyWMJ3tDPJrSqLfhzckPnsganXL9scOd+4J/RDsXgng+jUACOqerwkpC9
        EHoxMWSpKU0BtiI9KMJWzZNAm2TighR2BErpCSPDFc+JtlDLTm+or99lAeaAO6pId1ft
        zoJQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/HYoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w39C9MM1q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 9 Apr 2020 14:09:22 +0200 (CEST)
Date:   Thu, 9 Apr 2020 14:09:18 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexandre Bard <alexandre.bard@netmodule.com>
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
Message-ID: <20200409120918.GA54520@gerhold.net>
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
 <20200409110128.GA53758@gerhold.net>
 <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 09, 2020 at 01:50:24PM +0200, Alexandre Bard wrote:
> Le 09.04.20 à 13:01, Stephan Gerhold a écrit :
> > On Thu, Apr 09, 2020 at 10:58:18AM +0200, Alexandre Bard wrote:
> >> Former code was iterating through all possible IDs whereas only a few
> >> per settings array are really available. Leading to several out of
> >> bounds readings.
> >>
> >> Line is now longer than 80 characters. But since it is a classic for
> >> loop I think it is better to keep it like this than splitting it.
> >>
> >> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
> >> ---
> >>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> index 84d219ae6aee..be8882ff30eb 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> >> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> >>  	int err, i, j, data;
> >>  
> >>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> >> -		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> >> +		for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {
> > id in st_lsm6dsx_settings is declared as:
> >
> > 	struct {
> > 		enum st_lsm6dsx_hw_id hw_id;
> > 		const char *name;
> > 	} id[ST_LSM6DSX_MAX_ID];
> >
> > so it's always ST_LSM6DSX_MAX_ID long
> > (additional entries are just zero-initialized).
> >
> > Isn't ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id) == ST_LSM6DSX_MAX_ID
> > in this case?
> Yes, you are right, I missed that. But there is still a problem :
> parsing 0-initialized fields can lead to a false positive when looking for the
> value ST_LSM6DS3_ID which is the first element of an enum. So either the enum
> must be patched to start at 1 or the length of valid ids in a settings must be
> retrieved somehow.
> 
> Or is there another way ? Or am I wrong ?

ST_LSM6DS3_ID was indeed broken, which is why I added a .name != NULL
check in commit fb4fbc8904e7 ("iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID").

.name is only set for properly initialized IDs, so this ensures that we
do not match any zero-initialized entries. :)

> >
> >>  			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> >>  			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> >>  				break;
> >> -- 
> >> 2.20.1
> >>
