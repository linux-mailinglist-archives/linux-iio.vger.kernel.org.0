Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9948C11E13E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 10:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMJzr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 04:55:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52134 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbfLMJzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 04:55:47 -0500
X-Greylist: delayed 2039 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 04:55:45 EST
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ifh8p-0002Lp-1I; Fri, 13 Dec 2019 11:21:43 +0200
Message-ID: <3fc87add008ee42892f747bc247f15e09f6ed2d4.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Date:   Fri, 13 Dec 2019 11:21:40 +0200
In-Reply-To: <1576075099-3441-11-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
         <1576075099-3441-11-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 10/12] wireless: iwlwifi: use <linux/units.h> helpers
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2019-12-11 at 23:38 +0900, Akinobu Mita wrote:
> This switches the iwlwifi driver to use celsius_to_kelvin() and
> kelvin_to_celsius() in <linux/units.h>.
> 
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Intel Linux Wireless <linuxwifi@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.

