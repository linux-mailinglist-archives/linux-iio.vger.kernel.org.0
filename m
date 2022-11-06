Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0461E36D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKFQcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 11:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKFQcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 11:32:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35602A1AE
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 08:32:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DACAAB80690
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 16:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780B5C433D6;
        Sun,  6 Nov 2022 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667752329;
        bh=JsM9rxpHjKn32Nnmq/r6hhZ4/i6zF4zM7iUqV3TVTI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMhr0P/QsZufL1aY1UkyTQnmfMORg6DRcvvoxwKs+n1nPYWja9v3XA892ujC62/CM
         iXqg2C4kZwyjJ9aE7nrEkH4kNwpmkWj8DT3PzYuboQqYobOv3RZHli0e2o7kkvg/un
         56Ww4NgMxQGeVxpbsK+3Z+FxUQaXLkQRYNofdi0ZQxoB7N7Hgv3Itfy6u+J0kCJ3YW
         tInRXKyhMVnhaeijX3E9OXw58y8otNT1swm3eS3I67MlB7EEorw1IdMjwo+cUXxDRm
         xCp9dD/zYp+O8LILrOzTFKhynmLbSyHqhd4jB6ELuR7HeL8VyNdqkn2eZ3uIBeOFyh
         wmaq6En51sxiA==
Date:   Sun, 6 Nov 2022 16:32:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     linux-iio@vger.kernel.org, Jordi Torres <majosamaso@gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9360: Add a new ACPI hardware ID
Message-ID: <20221106163200.7f889ade@jic23-huawei>
In-Reply-To: <20221105225157.10081-1-gwendal@chromium.org>
References: <20221105225157.10081-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Nov 2022 15:51:57 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> From
> https://treexy.com/products/driver-fusion/database/sensors/semtech/sx9360-proximity/
> 
> sx9360 SAR sensor can be presented with ACPI ID SAMM0208.
> 
> Reported-by: Jordi Torres <majosamaso@gmail.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9360.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index d9a12e6be6ca6..4ebc5784aa6d9 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -865,6 +865,7 @@ static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
>  
>  static const struct acpi_device_id sx9360_acpi_match[] = {
>  	{ "STH9360", SX9360_WHOAMI_VALUE },
> +	{ "SAMM0208", SX9360_WHOAMI_VALUE },

SAMM doesn't immediately seem to be a valid ACPI vendor ID.
Anyone have a path to poke people to do this right or confirm whose ID that one is?

Reality is we'll have to live with it, but I like to complain first in vague hope that
people will one day play by the rules!  Given semtech has a PNP ID (STH is valid)
I'm not sure why someone would use an ACPI ID that doesn't seem to be (unless it
is very recent and no one has updated the DB on uefi.org yet).

Jonathan


>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9360_acpi_match);

