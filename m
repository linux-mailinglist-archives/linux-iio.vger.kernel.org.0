Return-Path: <linux-iio+bounces-17028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7762A67824
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD651883954
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5820F063;
	Tue, 18 Mar 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiDLmn4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5428FD;
	Tue, 18 Mar 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312565; cv=none; b=lyuOnD4wixrzQwwNqdAIkPLp1fjxPNqhuHfJjow2Q8j7gN3b0eu0+Ifu1Wsnc8prrJDyNExscdVriOEo5vUI0lQfzvYP8yPihGo7JwPH9ZmAgohqmVRJ+vhMsMQGNKg5qD+mq7iUS1UGq4uoblmlJwYE1fyZHJ7gX3dHsMfACbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312565; c=relaxed/simple;
	bh=bFYECgxboP4+QjxLmRsuA/NSM0Shj/GKwwVegaDxJYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJKr8L842mCgvfT5GlxBC51aaMirn+39t7OIxq0eg364o8n10xMzHgmXPwqlqs5Fp1VadpcnnB0seL+KzrFo6Yjxvs5cPgoJ136ksUZZYao41ctatLHglrtMwkDIAQ7Dk+v5QfNeWQcF0Tpqz96EpGMG5c65gbDGxmqW3vQmmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiDLmn4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19E0C4CEE3;
	Tue, 18 Mar 2025 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312565;
	bh=bFYECgxboP4+QjxLmRsuA/NSM0Shj/GKwwVegaDxJYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiDLmn4eS05wFXdJc5BT57uAh2r/acIxX5f59PS0sd0ZUNJt/UNlyfLfJ4XxvtIqJ
	 CeN5q+vb7P7Wp0ULDZCmYersbzLyE7dHzwIXfZ/urlF5D+3kgXEtZJYc7TbLUPa8gv
	 aifB0fXhlaVShbH+IJ4vOCSNvaygdUMOI+oWdU6DNyXNs86YS1zD+4unPmrugnyJyi
	 nf8ABJnVL4HkPvKomIS2JH8mkwMvhnYMT5j5ldg/ruLuvG+upJUuRW4ckYqJGnHoPf
	 h8b89iamAIO+o5zTNV3jTry0O/XW/uPdoXdWWAg/mmqs2nTX/+AC8+uwpNaR9dEyBw
	 nCrkxfRvoF1lA==
Date: Tue, 18 Mar 2025 08:42:41 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iio: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202503180840.77F2F47DE8@keescook>
References: <Z9lE6IVDeC5lnChN@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lE6IVDeC5lnChN@kspp>

On Tue, Mar 18, 2025 at 08:33:20PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:39:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use MAX() to calculate the number of bytes for the flex array. (Kees)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z9dy43vUUh4goi-Q@kspp/
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 ++++++++-----------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 7751d6f69b12..40d5b10c74e0 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -34,25 +34,19 @@
>  static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  					     u16 cmd_offset, u16 cmd, u32 *mask)
>  {
> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
> +			MAX(sizeof(struct ec_response_get_cmd_versions),
> +			    sizeof(struct ec_params_get_cmd_versions)));
>  	int ret;
> -	struct {
> -		struct cros_ec_command msg;
> -		union {
> -			struct ec_params_get_cmd_versions params;
> -			struct ec_response_get_cmd_versions resp;
> -		};
> -	} __packed buf = {
> -		.msg = {
> -			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> -			.insize = sizeof(struct ec_response_get_cmd_versions),
> -			.outsize = sizeof(struct ec_params_get_cmd_versions)
> -			},
> -		.params = {.cmd = cmd}
> -	};
> -
> -	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +
> +	buf->command = EC_CMD_GET_CMD_VERSIONS + cmd_offset;
> +	buf->insize = sizeof(struct ec_response_get_cmd_versions);
> +	buf->outsize = sizeof(struct ec_params_get_cmd_versions);
> +	((struct ec_params_get_cmd_versions *)buf->data)->cmd = cmd;
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, buf);
>  	if (ret >= 0)
> -		*mask = buf.resp.version_mask;
> +		*mask = ((struct ec_response_get_cmd_versions *)buf->data)->version_mask;
>  	return ret;
>  }

Since "params" is used twice, I'd say do like the other patch and assign
it to a new variable:

	struct ec_response_get_cmd_versions *params = buf->data;
	...
	params->cmd = cmd;
	...
		*mask = params->version_mask;


>  
> -- 
> 2.43.0
> 

-- 
Kees Cook

