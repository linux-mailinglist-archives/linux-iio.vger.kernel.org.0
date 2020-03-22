Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69818EBE2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVTRy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 15:17:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23715 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgCVTRy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:17:54 -0400
X-IronPort-AV: E=Sophos;i="5.72,293,1580770800"; 
   d="scan'208";a="441562746"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 20:17:52 +0100
Date:   Sun, 22 Mar 2020 20:17:52 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <mh12gx2825@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] media: staging/intel-ipu3: Reformat
 pointer initialization
In-Reply-To: <20200322185350.GA12377@deeUbuntu>
Message-ID: <alpine.DEB.2.21.2003222017290.2325@hadrien>
References: <20200322185350.GA12377@deeUbuntu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Mon, 23 Mar 2020, Deepak R Varma wrote:

> Reformat pointer initialization to make it more readable as per the
> coding standards. Problem detected by checkpatch.
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>
> Changes since v1:
>     - Correct commit message and description as advised vy Stefano. Its
>       pointer initialization and not declaration as mentioned earlier.
>
>  drivers/staging/media/ipu3/ipu3-v4l2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index 569e27b824c8..52826fad6f42 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -485,7 +485,6 @@ static int imgu_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	if (r < 0)
>  		goto fail_return_bufs;
>
> -

This change shouldn't be part of this patch.

julia

>  	if (!imgu_all_nodes_streaming(imgu, node))
>  		return 0;
>
> @@ -1013,8 +1012,9 @@ static const struct v4l2_ioctl_ops imgu_v4l2_meta_ioctl_ops = {
>
>  static int imgu_sd_s_ctrl(struct v4l2_ctrl *ctrl)
>  {
> -	struct imgu_v4l2_subdev *imgu_sd =
> -		container_of(ctrl->handler, struct imgu_v4l2_subdev, ctrl_handler);
> +	struct imgu_v4l2_subdev *imgu_sd = container_of(ctrl->handler,
> +							struct imgu_v4l2_subdev,
> +							ctrl_handler);
>  	struct imgu_device *imgu = v4l2_get_subdevdata(&imgu_sd->subdev);
>  	struct device *dev = &imgu->pci_dev->dev;
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200322185350.GA12377%40deeUbuntu.
>
