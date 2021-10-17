Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1643097A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbhJQNxy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242336AbhJQNxy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 09:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D46461027;
        Sun, 17 Oct 2021 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634478704;
        bh=wJArX8ewuoelcOM089foeU0E8LxBl4M7aRz9fvqueNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhXRwrmqyiUM3WRs8L1qda973z8Z3zVvIVtVapURG6io1+iA1xxt7uNRbZLGNcEzU
         yAcnJtEl3vN9HOOWs8UEYWCEHF+oM0roScDnXQQS2jrodW3uN0dCdvXh6zxd3OOPuE
         c3pXxNuNi35IWUHhgfdE54ORfkgHC8NyDu5cPcF0=
Date:   Sun, 17 Oct 2021 15:51:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v17 5/9] counter: Implement signalZ_action_component_id
 sysfs attribute
Message-ID: <YWwqbmSoLFxiKDTa@kroah.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
 <a6c81b2f1f5d0b8d59b1ebe4f0fed04914b07547.1632884256.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c81b2f1f5d0b8d59b1ebe4f0fed04914b07547.1632884256.git.vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 29, 2021 at 12:16:02PM +0900, William Breathitt Gray wrote:
> +static ssize_t counter_comp_id_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	const size_t id = (size_t)to_counter_attribute(attr)->comp.priv;
> +
> +	return sprintf(buf, "%zu\n", id);

sysfs_emit()?

> +}
> +

