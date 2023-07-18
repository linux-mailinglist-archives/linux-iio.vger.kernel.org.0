Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C524757831
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jul 2023 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGRJhI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jul 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRJhH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2023 05:37:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F9CF
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 02:37:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4tzP4qFwz67frD;
        Tue, 18 Jul 2023 17:33:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 10:37:03 +0100
Date:   Tue, 18 Jul 2023 10:37:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, Yiyuan Guo <yguoaz@gmail.com>,
        <lars@metafoo.de>, <bleung@chromium.org>, <groeck@google.com>,
        <dianders@chromium.org>, <mazziesaccount@gmail.com>,
        <gwendal@chromium.org>, <linux-iio@vger.kernel.org>,
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v3] iio: cros_ec: Fix the allocation size for
 cros_ec_command
Message-ID: <20230718103702.0000546e@Huawei.com>
In-Reply-To: <ZLSw1FxccNOqE52C@google.com>
References: <20230630143719.1513906-1-yguoaz@gmail.com>
        <20230716141028.4c57c5c7@jic23-huawei>
        <ZLSw1FxccNOqE52C@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jul 2023 11:09:08 +0800
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Sun, Jul 16, 2023 at 02:10:28PM +0100, Jonathan Cameron wrote:
> [...]
> > 2) Various people commented on earlier versions, and I'm waiting for them to confirm
> > they are fine with this version.  
> 
> The version addressed all my comments and LGTM.

Tag?  I can pick up without, but it's nice to record this
formally.   Reviewed-by seems appropriate here.
