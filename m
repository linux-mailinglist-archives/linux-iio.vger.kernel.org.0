Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DC6E628B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Apr 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjDRMdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Apr 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDRMda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 08:33:30 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA7D323
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 05:33:08 -0700 (PDT)
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q13Gh2K63z9spJ;
        Tue, 18 Apr 2023 14:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681821164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShsOSVROby/3Sl7xjt5XFiFHOABhlE2u7XInM4MT1LY=;
        b=KZynXrCh3PmHmhCukVLL/WDSwOUuPY0c+bHhFA9qyCpaST+s45NsWETm2R7R06pQqT3SKL
        wgkItsfkMXwAkIXcoMyZ34XUjcfjMQLidQzPKFiEQpnEYFVDh/OZFC2z1g6cAAk3DXcH/v
        nhXdnyq56T6t7xQc8pSITQjOzilQ1lgkUUgUAYeowGKnp5Jvu/2jZbrldRfEw9QeZg0G9E
        9YzNVSeCNquy6bRbkPSsSVd5nx+YhPHhBmW/QQk1EVsTSb85zBeoWmiMQ/kqK5b6UGewuF
        QvHfABpGqd+xbYqcAT+NBqts1jPfo16INNsl7KY5AJk6rzDLl5TXke/Yd0QVBA==
Message-ID: <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
Date:   Tue, 18 Apr 2023 14:32:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on devices
 without ACPI _ONT method
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230416212409.310936-1-hdegoede@redhat.com>
Content-Language: en-US
From:   Marius Hoch <mail@mariushoch.de>
In-Reply-To: <20230416212409.310936-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 16/04/2023 23:24, Hans de Goede wrote:
> When apply_acpi_orientation() fails, st_accel_common_probe() will fall back
> to iio_read_mount_matrix(), which checks for a mount-matrix device property
> and if that is not set falls back to the identity matrix.
>
> But when a sensor has no ACPI companion fwnode, or when the ACPI fwnode
> does not have a "_ONT" method apply_acpi_orientation() was returning 0,
> causing iio_read_mount_matrix() to never get called resulting in an
> invalid mount_matrix:
>
> [root@fedora ~]# cat /sys/bus/iio/devices/iio\:device0/mount_matrix
> (null), (null), (null); (null), (null), (null); (null), (null), (null)
>
> Fix this by making apply_acpi_orientation() always return an error when
> it did not set the mount_matrix.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested, with the LSM303D patches applied, on a Lenovo Yoga Tablet 2 1051-F.

Tested-by: Marius Hoch <mail@mariushoch.de>


> ---
>   drivers/iio/accel/st_accel_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 1628b177d0ed..f7b823ebc96b 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1291,12 +1291,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>   
>   	adev = ACPI_COMPANION(indio_dev->dev.parent);
>   	if (!adev)
> -		return 0;
> +		return -ENXIO;
>   
>   	/* Read _ONT data, which should be a package of 6 integers. */
>   	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
>   	if (status == AE_NOT_FOUND) {
> -		return 0;
> +		return -ENXIO;
>   	} else if (ACPI_FAILURE(status)) {
>   		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
>   			 status);

