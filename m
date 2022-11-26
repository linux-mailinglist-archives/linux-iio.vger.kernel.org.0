Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9657C6397BE
	for <lists+linux-iio@lfdr.de>; Sat, 26 Nov 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKZS61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Nov 2022 13:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZS61 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:58:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EABBC94
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:58:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB3260C3F
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6FEC433C1;
        Sat, 26 Nov 2022 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669489105;
        bh=FOi6+x3UvKskPhXP3YkcyzEZt7uTpd6LRl/9xGMlqoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTKnTIoeLgNcxqctOv90JZpVyftRmi2YJONTzs6h0ElJa+7mkn7nIMQAilerpwJfZ
         /K9Ev/z8hQnOVsUymtxgj1jmMKwrES2fBU6tC6bypYJ9WwPUqT/n+Zm2awSLKUQO18
         rAcNe9Bc0MJX/VHs+jawhgTSJLsqijSOWWE6R/eBijfLsOYj9Hj90hMXQh5TjA480S
         kwR9P+O01nIBseCNU82GN7KKjBTkOrU+wqNPstdG4shpVuCQSLZKg2D20otXUNbtI2
         CkCP1CxJIpojkcQuDGH8eULmjYxdgeWrSbltcvDYacUihpwqdKW6BRtxNz/UgBf23p
         Fjxj8IShiGLVQ==
Date:   Sat, 26 Nov 2022 19:11:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/4] HID: hid-sensor-custom: Allow more custom iio
 sensors
Message-ID: <20221126191103.6ef517a1@jic23-huawei>
In-Reply-To: <20221124233841.3103-2-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <20221124233841.3103-2-p.jungkamp@gmx.net>
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

On Fri, 25 Nov 2022 00:38:38 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> The known LUID table for established/known custom HID sensors was
> limited to sensors with "INTEL" as manufacturer. But some vendors such
> as Lenovo also include fairly standard iio sensors (e.g. ambient light)
> in their custom sensors.
> 
> Expand the known custom sensors table by a tag used for the platform
> device name and match sensors based on the LUID as well as optionally
> on model and manufacturer properties.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
