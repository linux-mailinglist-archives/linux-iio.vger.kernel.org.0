Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4181F7A74A3
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjITHqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjITHqE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 03:46:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223710D9
        for <linux-iio@vger.kernel.org>; Wed, 20 Sep 2023 00:45:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E69C433C9;
        Wed, 20 Sep 2023 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195928;
        bh=vyU8wQPi6oh/NjWmtzvVpS8tL4Q//A1RZnrGiTgWwE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+tpIOP9B9Kw6nLCMGc/BdMZVi9Y8skhvp2CX1mePe4qQFSCe4m3f7n7WkU3X8JI5
         lsMU338oKFGg81pTihTKNfqOIuSJ2PQgvOzIA+0tvRndpPspxcKnQuA/g4cj9x7Fn8
         P4UNbY9ctJsrIqtrwKfLmWr8QhjTYWwfykRh9JiNEjRgY30BtYvxxkAouHVQ6nijhl
         s+AoKczkyld3fKOfwxICbXS6qJXEnEjypt4vDWTppT9pf7uE38n8tmx01wUchwo0gg
         PH0xeQadAa6f4q1d65VoDOUXrROHlm8cre1mBWWEMPgroXrVAoyAjFqPxOSu89xPcr
         cuoBlFdIHUURQ==
Date:   Wed, 20 Sep 2023 15:45:25 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 45/49] iio: proximity: cros_ec_mkbp: Convert to platform
 remove callback returning void
Message-ID: <ZQqjFWBPti2c734w@google.com>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
 <20230919174931.1417681-46-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919174931.1417681-46-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 19, 2023 at 07:49:27PM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
