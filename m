Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050FB1508E2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 15:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBCO6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 09:58:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:17706 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgBCO6h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Feb 2020 09:58:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 06:58:36 -0800
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="337484458"
Received: from montimix-mobl.gar.corp.intel.com ([10.251.72.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 06:58:30 -0800
Message-ID: <5eb0bed279933a259f7a82314abf1d83246aa602.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] SFH: Transport Driver to add support of AMD
 sensor fusion Hub (SFH)
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Date:   Mon, 03 Feb 2020 06:58:27 -0800
In-Reply-To: <1580272046-32101-4-git-send-email-Sandeep.Singh@amd.com>
References: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
         <1580272046-32101-4-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-01-29 at 09:57 +0530, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> This part of module will provide the interaction between HID
> framework
> and client driver.This modules will registered client driver with
> HID framework.
> 
Better to have two patches. One for debugfs specific and one client
driver.

> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/hid/amd-sfh-hid/amdsfh-debugfs.c    | 251
> ++++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amdsfh-debugfs.h    |  14 ++
>  drivers/hid/amd-sfh-hid/amdsfh-hid-client.c | 261
> ++++++++++++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amdsfh-hid.c        | 179
> +++++++++++++++++++
>  drivers/hid/amd-sfh-hid/amdsfh-hid.h        |  85 +++++++++
>  5 files changed, 790 insertions(+)
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
> 
> diff --git a/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
> b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
> new file mode 100644
> index 0000000..20859d4
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  AMD SFH DebugFS
> + *  This part of module will provide sensors raw value data
> + *  for AMD SFH debugging.
> + *  cat /sys/kernel/debug/amd_sfhtp_hid
> + *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com
> >
> + */
> +
> +#include <linux/slab.h>
> +#include "amd_mp2_pcie.h"
> +#include "amdsfh-debugfs.h"
> +
> +/* DebugFS helpers */
> +#define	OBUFP		(obuf + oboff)
> +#define	OBUFLEN		512
> +#define	OBUFSPC		(OBUFLEN - oboff)
> +#define	OSCNPRINTF(fmt, ...) \
> +		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
> +
> +static ssize_t amdsfh_debugfs_accel_read(struct file *filp, char
> __user *ubuf,
> +					 size_t count, loff_t *offp)
> +{
> +	unsigned int oboff = 0, i;
> +	struct amdtp_cl_data *cl_data = filp->private_data;
> +	bool found = false;
> +	ssize_t ret;
> +	char *obuf;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		if (cl_data->sensor_idx[i] == ACCEL_IDX) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -1;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += OSCNPRINTF("Accel_X_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][0]);
> +	oboff += OSCNPRINTF("Accel_Y_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][1]);
> +	oboff += OSCNPRINTF("Accel_Z_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][2]);
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +static ssize_t amdsfh_debugfs_gyro_read(struct file *filp, char
> __user *ubuf,
> +					size_t count, loff_t *offp)
> +{
> +	unsigned int oboff = 0, i;
> +	bool found = false;
> +	struct amdtp_cl_data *cl_data = filp->private_data;
> +	ssize_t ret;
> +	char *obuf;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		if (cl_data->sensor_idx[i] == GYRO_IDX) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -1;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += OSCNPRINTF("Gyro_X_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][0]);
> +	oboff += OSCNPRINTF("Gyro_Y_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][1]);
> +	oboff += OSCNPRINTF("Gyro_Z_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][2]);
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +static ssize_t amdsfh_debugfs_mag_read(struct file *filp, char
> __user *ubuf,
> +				       size_t count, loff_t *offp)
> +{
> +	unsigned int oboff = 0, i;
> +	bool found = false;
> +	ssize_t ret;
> +	char *obuf;
> +	struct amdtp_cl_data *cl_data = filp->private_data;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		if (cl_data->sensor_idx[i] == MAG_IDX) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -1;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += OSCNPRINTF("Mag_X_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][0]);
> +	oboff += OSCNPRINTF("Mag_Y_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][1]);
> +	oboff += OSCNPRINTF("Mag_Z_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][2]);
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +static ssize_t amdsfh_debugfs_als_read(struct file *filp, char
> __user *ubuf,
> +				       size_t count, loff_t *offp)
> +{
> +	unsigned int oboff = 0, i;
> +	bool found = false;
> +	ssize_t ret;
> +	char *obuf;
> +	struct amdtp_cl_data *cl_data = filp->private_data;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		if (cl_data->sensor_idx[i] == AMBIENT_LIGHT_IDX) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -1;
> +
> +	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
> +	if (!obuf)
> +		return -ENOMEM;
> +
> +	oboff += OSCNPRINTF("Gyro_X_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][0]);
> +	oboff += OSCNPRINTF("Gyro_Y_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][1]);
> +	oboff += OSCNPRINTF("Gyro_Z_Raw:%d\n",
> +		(int)cl_data->sensor_virt_addr[i][2]);
> +	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
> +
> +	kfree(obuf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations amdsfh_debugfs_accel_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amdsfh_debugfs_accel_read,
> +};
> +
> +static const struct file_operations amdsfh_debugfs_gyro_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amdsfh_debugfs_gyro_read,
> +};
> +
> +static const struct file_operations amdsfh_debugfs_mag_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amdsfh_debugfs_mag_read,
> +};
> +
> +static const struct file_operations amdsfh_debugfs_als_ops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.read = amdsfh_debugfs_als_read,
> +};
> +
> +int amdsfh_debugfs_setup(struct amdtp_cl_data *cl_data)
> +{
> +	/* DebugFS info */
> +	struct dentry *dbgfs;
> +	int i;
> +
> +	if (!debugfs_initialized())
> +		return -1;
> +
> +	if (!cl_data->amd_debugfs_dir)
> +		cl_data->amd_debugfs_dir = debugfs_create_dir
> +					(KBUILD_MODNAME, NULL);
> +
> +	if (!cl_data->amd_debugfs_dir)
> +		return -1;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		switch (cl_data->sensor_idx[i]) {
> +		case ACCEL_IDX:
> +			dbgfs = debugfs_create_dir("accel",
> +						   cl_data-
> >amd_debugfs_dir);
> +			debugfs_create_file("raw_value", 0400,
> +					    dbgfs, cl_data,
> +					    &amdsfh_debugfs_accel_ops);
> +			break;
> +
> +		case GYRO_IDX:
> +			dbgfs = debugfs_create_dir("gyro",
> +						   cl_data-
> >amd_debugfs_dir);
> +			debugfs_create_file("raw_value", 0400,
> +					    dbgfs, cl_data,
> +					    &amdsfh_debugfs_gyro_ops);
> +			break;
> +
> +		case MAG_IDX:
> +			 dbgfs = debugfs_create_dir("magnetometer",
> +						    cl_data-
> >amd_debugfs_dir);
> +			 debugfs_create_file("raw_value", 0400,
> +					     dbgfs, cl_data,
> +					     &amdsfh_debugfs_mag_ops);
> +			break;
> +
> +		case AMBIENT_LIGHT_IDX:
> +			 dbgfs =  debugfs_create_dir("als",
> +						     cl_data-
> >amd_debugfs_dir);
> +			 debugfs_create_file("raw_value", 0400,
> +					     dbgfs, cl_data,
> +					     &amdsfh_debugfs_als_ops);
> +			break;
> +
> +		default:
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(amdsfh_debugfs_setup);
> +
> +void amdsfh_debugfs_destroy(struct amdtp_cl_data *cl_data)
> +{
> +	debugfs_remove_recursive(cl_data->amd_debugfs_dir);
> +}
> +EXPORT_SYMBOL(amdsfh_debugfs_destroy);
> diff --git a/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
> b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
> new file mode 100644
> index 0000000..470f1f12
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amdsfh-debugfs.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + *  AMD SFH DebugFS
> + *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com
> >
> + */
> +#include "amdsfh-hid.h"
> +
> +#ifndef AMDSFH_DEBUGFS_H
> +#define AMDSFH_DEBUGFS_H
> +
> +int amdsfh_debugfs_setup(struct amdtp_cl_data *cl_data);
> +void amdsfh_debugfs_destroy(struct amdtp_cl_data *cl_data);
> +
> +#endif
> diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
> b/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
> new file mode 100644
> index 0000000..b59cb2f
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + *  AMD SFH Client Driver
> + *  Author: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com
> >
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <linux/hid.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/dma-mapping.h>
> +#include "amdsfh-hid.h"
> +#include "amd_mp2_pcie.h"
> +#include "hid_descriptor/amd_sfh_hid_descriptor.h"
> +#include "amdsfh-debugfs.h"
> +
> +#define DRIVER_DESC	"AMD(R) PCIe MP2 Communication Client Driver"
> +#define DRIVER_VER	"1.0"
> +#define DRIVER_NAME "AMD_SFH_HID_CLIENT"
> +#define PERIOD  200
> +
> +struct request_list {
> +	u8 report_id;
> +	u8 sensor_idx;
> +	u8 report_type;
> +	u8 current_index;
> +	struct hid_device *hid;
> +	struct list_head list;
> +};
> +
> +static struct request_list req_list;
> +static struct amdtp_cl_data *cl_data_context;
> +
> +void amd_sfh_set_report(struct hid_device *hid, int report_id,
> +			int report_type)
> +{
> +	struct amdtp_hid_data *hid_data = hid->driver_data;
> +	struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +	int i;
> +
> +	for (i = 0; i < cli_data->num_hid_devices; i++) {
> +		if (cli_data->hid_sensor_hubs[i] == hid) {
> +			cli_data->cur_hid_dev = i;
> +			break;
> +		}
> +	}
> +	amdtp_hid_wakeup(hid);
> +}
> +EXPORT_SYMBOL(amd_sfh_set_report);
> +
> +void amd_sfh_get_report(struct hid_device *hid, int report_id,
> +			int report_type)
> +{
> +	struct amdtp_hid_data *hid_data = hid->driver_data;
> +	struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +	int i;
> +
> +	for (i = 0; i < cli_data->num_hid_devices; i++) {
> +		if (cli_data->hid_sensor_hubs[i] == hid) {
> +			struct request_list *new_request = kzalloc
> +				  (sizeof(*new_request), GFP_KERNEL);
> +			new_request->current_index = i;
> +			new_request->sensor_idx = cli_data-
> >sensor_idx[i];
> +			new_request->hid = hid;
> +			new_request->report_type = report_type;
> +			new_request->report_id = report_id;
> +			cli_data->report_id[i] = report_id;
> +			cli_data->request_done[i] = false;
> +			list_add(&new_request->list, &req_list.list);
> +			break;
> +		}
> +	}
> +	schedule_delayed_work(&cli_data->work, 0);
> +}
> +EXPORT_SYMBOL(amd_sfh_get_report);
> +
> +static void amd_sfh_work(struct work_struct *work)
> +{
> +	struct amdtp_cl_data *cli_data = amd_sfh_cldata(work);
> +	struct request_list *req_node;
> +	u8 report_size = 0;
> +	u8 current_index;
> +	u8 sensor_index;
> +	u8 report_id;
> +	u8 node_type;
> +
> +	req_node = list_last_entry(&req_list.list, struct request_list,
> list);
> +	list_del(&req_node->list);
> +	current_index = req_node->current_index;
> +	sensor_index = req_node->current_index;
> +	report_id = req_node->report_id;
> +	node_type = req_node->report_type;
> +
> +	if (node_type == HID_FEATURE_REPORT) {
> +		report_size = get_feature_report(sensor_index,
> report_id,
> +						 cli_data-
> >feature_report
> +						 [current_index]);
> +	} else if (node_type == HID_INPUT_REPORT) {
> +		report_size = get_input_report(sensor_index, report_id,
> +					       cli_data->input_report
> +						[current_index],
> +						cli_data-
> >sensor_virt_addr
> +						[current_index]);
> +	}
> +
> +	hid_input_report(cli_data->hid_sensor_hubs[current_index],
> +			 cli_data->report_type[current_index],
> +				 cli_data->input_report[current_index],
> +				report_size, 0);
> +	cli_data->cur_hid_dev = current_index;
> +	cli_data->sensor_requested_cnt[current_index] = 0;
> +	kfree(req_node);
> +	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
> +}
> +
> +static void amd_sfh_work_buffer(struct work_struct *work)
> +{
> +	struct amdtp_cl_data *cli_data = cl_data_context;
> +	unsigned int i;
> +	u8 report_size = 0;
> +
> +	for (i = 0; i < cli_data->num_hid_devices; i++) {
> +		report_size = get_input_report(cli_data->sensor_idx[i],
> +					       cli_data->report_id[i],
> +				cli_data->input_report[i],
> +				cli_data->sensor_virt_addr[i]);
> +		hid_input_report(cli_data->hid_sensor_hubs[i],
> +				 HID_INPUT_REPORT,
> +				 cli_data->input_report[i],
> report_size, 0);
> +		}
> +
> +	schedule_delayed_work(&cli_data->work_buffer, PERIOD);
> +}
> +
> +static int amd_sfh_hid_client_probe(struct platform_device *pdev)
> +{
> +	struct amd_mp2_sensor_info info;
> +	int rc = 0;
> +	int i;
> +	struct amdtp_cl_device *cl_dev;
> +	struct amdtp_cl_data *cl_data;
> +	u32 feature_report_size = 0;
> +	u32 input_report_size = 0;
> +
> +	cl_dev = devm_kzalloc(&pdev->dev, sizeof(*cl_dev), GFP_KERNEL);
> +	if (!cl_dev)
> +		return -ENOMEM;
Here you are using devm_ call. So better to be consistant and use
everywhere devm_

> +
> +	cl_dev->pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +				      PCI_DEVICE_ID_AMD_MP2, NULL);
> +	if (!cl_dev->pdev)
> +		return -ENOMEM;
> +
> +	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
> +	cl_data->num_hid_devices = amd_mp2_get_sensor_num
> +				   (cl_dev->pdev, &cl_data-
> >sensor_idx[0]);
> +
> +	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
> +	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
> +	INIT_LIST_HEAD(&req_list.list);
> +
> +	amdsfh_debugfs_setup(cl_data);
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		cl_data->sensor_virt_addr[i] = dma_alloc_coherent
> +			(&pdev->dev, sizeof(int) * 8,
> +			&cl_data->sensor_phy_addr[i], GFP_KERNEL);
> +		cl_data->sensor_sts[i] = 0;
> +		cl_data->sensor_requested_cnt[i] = 0;
> +		cl_data->cur_hid_dev = i;
> +
> +		cl_data->report_descr_size[i] = get_descriptor_size
> +				(cl_data->sensor_idx[i], descr_size);
> +
> +		feature_report_size = get_descriptor_size
> +				(cl_data->sensor_idx[i], feature_size);
> +
> +		input_report_size =  get_descriptor_size
> +			(cl_data->sensor_idx[i], input_size);
> +
> +		cl_data->feature_report[i] =
> kzalloc(feature_report_size,
> +						     GFP_KERNEL);
> +		cl_data->input_report[i] = kzalloc(input_report_size,
> +						   GFP_KERNEL);
> +		info.period = PERIOD;
> +		info.sensor_idx = cl_data->sensor_idx[i];
> +		info.phy_address = cl_data->sensor_phy_addr[i];
> +		cl_data->report_descr[i] = kzalloc
> +			(cl_data->report_descr_size[i], GFP_KERNEL);
> +		if (!cl_data->report_descr[i])
> +			return -ENOMEM;
> +		rc = get_report_descriptor(cl_data->sensor_idx[i],
> +					   cl_data->report_descr[i]);
> +		rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
> +		rc = amd_start_sensor(cl_dev->pdev, info);
> +			cl_data->sensor_sts[i] = 1;
> +	}
> +
> +	cl_dev->cl_data = cl_data;
> +	cl_data_context = cl_data;
> +	platform_set_drvdata(pdev, cl_dev);
> +	schedule_delayed_work(&cl_data->work_buffer, PERIOD);
> +	return 0;
> +}
> +
> +static int amd_sfh_hid_client_remove(struct platform_device *pdev)
> +{
> +	int i;
> +	struct amdtp_cl_device *cl_dev;
> +	struct amdtp_cl_data *cl_data;
> +
> +	cl_dev = platform_get_drvdata(pdev);
> +	if (!(cl_dev))
> +		return -EINVAL;
> +
> +	cl_data = cl_dev->cl_data;
> +	if (!(cl_data))
> +		return -EINVAL;
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++)
> +		amd_stop_sensor(cl_dev->pdev, i);
one space

Thanks,
Srinivas

> +	cancel_delayed_work_sync(&cl_data->work);
> +	cancel_delayed_work_sync(&cl_data->work_buffer);
> +	amdsfh_debugfs_destroy(cl_data);
> +	amdtp_hid_remove(cl_data);
> +
> +	for (i = 0; i < cl_data->num_hid_devices; i++) {
> +		if (cl_data->sensor_virt_addr[i])
> +			dma_free_coherent(&pdev->dev, 8 * sizeof(int),
> +					  cl_data->sensor_virt_addr[i],
> +					  cl_data->sensor_phy_addr[i]);
> +	}
> +
> +	kfree(cl_data);
> +	pr_info("%s:%s Exit\n", DRIVER_NAME, __func__);
> +	return 0;
> +}
> +
> +static const struct acpi_device_id amd_sfh_acpi_match[] = { {
> +					"AMDI0080" },
> +					{ },
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, amd_sfh_acpi_match);
> +static struct platform_driver amd_sfh_plat_driver = {
> +	.probe = amd_sfh_hid_client_probe,
> +	.remove = amd_sfh_hid_client_remove,
> +	.driver = {
> +			.name = "amd_sfh_platform",
> +			.acpi_match_table =
> ACPI_PTR(amd_sfh_acpi_match),
> +	},
> +};
> +module_platform_driver(amd_sfh_plat_driver);
> +MODULE_DESCRIPTION("AMD(R) SFH Client Driver");
> +MODULE_AUTHOR("Nehal Shah <nehal-bakulchandra.shah@amd.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid.c b/drivers/hid/amd-
> sfh-hid/amdsfh-hid.c
> new file mode 100644
> index 0000000..89fe35a8
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amdsfh-hid.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * AMD MP2 Sensors transport  driver
> + *
> + * Authors: Sandeep Singh <sandeep.singh@amd.com>
> + *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com
> >
> + */
> +#include <linux/hid.h>
> +#include <linux/wait.h>
> +#include <linux/sched.h>
> +#include "amdsfh-hid.h"
> +
> +#define DRIVER_NAME "AMD_MP2_SENSORS_TRANSPORT"
> +
> +/**
> + * amdtp_hid_parse() - hid-core .parse() callback
> + * @hid:	hid device instance
> + *
> + * This function gets called during call to hid_add_device
> + *
> + * Return: 0 on success and non zero on error
> + */
> +static int amdtp_hid_parse(struct hid_device *hid)
> +{
> +	struct amdtp_hid_data *hid_data = hid->driver_data;
> +	struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +	int rc;
> +
> +	rc = hid_parse_report(hid, cli_data->report_descr[hid_data-
> >index],
> +			      cli_data->report_descr_size[hid_data-
> >index]);
> +	if (rc)
> +		return rc;
> +	return 0;
> +}
> +
> +/* Empty callbacks with success return code */
> +static int amdtp_hid_start(struct hid_device *hid)
> +{
> +	return 0;
> +}
> +
> +static void amdtp_hid_stop(struct hid_device *hid)
> +{
> +}
> +
> +static int amdtp_hid_open(struct hid_device *hid)
> +{
> +	return 0;
> +}
> +
> +static void amdtp_hid_close(struct hid_device *hid)
> +{
> +}
> +
> +static int amdtp_raw_request(struct hid_device *hdev, unsigned char
> reportnum,
> +			     u8 *buf, size_t len, unsigned char rtype,
> +			     int reqtype)
> +{
> +	return 0;
> +}
> +
> +static void amdtp_hid_request(struct hid_device *hid, struct
> hid_report *rep,
> +			      int reqtype)
> +{
> +	switch (reqtype) {
> +	case HID_REQ_GET_REPORT:
> +		amd_sfh_get_report(hid, rep->id, rep->type);
> +		break;
> +	case HID_REQ_SET_REPORT:
> +		amd_sfh_set_report(hid, rep->id, reqtype);
> +		break;
> +	}
> +}
> +
> +static int amdtp_wait_for_response(struct hid_device *hid)
> +{
> +	struct amdtp_hid_data *hid_data =  hid->driver_data;
> +	struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +	int i = 0;
> +
> +	for (i = 0; i < cli_data->num_hid_devices; i++) {
> +		if (cli_data->hid_sensor_hubs[i] == hid)
> +			break;
> +	}
> +	if (!cli_data->request_done[i])
> +		wait_event_interruptible_timeout(hid_data->hid_wait,
> +						 cli_data-
> >request_done[i],
> +						 1500);
> +	if (!cli_data->request_done[i]) {
> +		hid_err(hid,
> +			"timeout waiting for response from  device\n");
> +		return -ETIMEDOUT;
> +	}
> +	cli_data->request_done[i] = false;
> +
> +	return 0;
> +}
> +
> +void amdtp_hid_wakeup(struct hid_device *hid)
> +{
> +	struct amdtp_hid_data *hid_data = hid->driver_data;
> +	struct amdtp_cl_data *cli_data = hid_data->cli_data;
> +
> +	cli_data->request_done[cli_data->cur_hid_dev] = true;
> +	wake_up_interruptible(&hid_data->hid_wait);
> +}
> +
> +static struct hid_ll_driver amdtp_hid_ll_driver = {
> +	.parse	=	amdtp_hid_parse,
> +	.start	=	amdtp_hid_start,
> +	.stop	=	amdtp_hid_stop,
> +	.open	=	amdtp_hid_open,
> +	.close	=	amdtp_hid_close,
> +	.request  =	amdtp_hid_request,
> +	.wait	=	amdtp_wait_for_response,
> +	.raw_request  =	amdtp_raw_request,
> +};
> +
> +int amdtp_hid_probe(unsigned int cur_hid_dev,
> +		    struct amdtp_cl_data *cli_data)
> +{
> +	int rc;
> +	struct hid_device *hid;
> +	struct amdtp_hid_data *hid_data;
> +
> +	hid = hid_allocate_device();
> +	if (IS_ERR(hid)) {
> +		rc = PTR_ERR(hid);
> +		return -ENOMEM;
> +	}
> +
> +	hid_data = kzalloc(sizeof(*hid_data), GFP_KERNEL);
> +	if (!hid_data) {
> +		rc = -ENOMEM;
> +		goto err_hid_data;
> +	}
> +
> +	hid->ll_driver = &amdtp_hid_ll_driver;
> +	hid_data->index = cur_hid_dev;
> +	hid_data->cli_data = cli_data;
> +	init_waitqueue_head(&hid_data->hid_wait);
> +
> +	hid->driver_data = hid_data;
> +	cli_data->hid_sensor_hubs[cur_hid_dev] = hid;
> +	hid->bus = BUS_AMD_AMDTP;
> +	hid->version = AMD_SFH_HID_VERSION;
> +	hid->vendor = AMD_SFH_HID_VENDOR;
> +	hid->product = AMD_SFH_HID_PRODUCT;
> +	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-
> amdtp",
> +		 hid->vendor, hid->product);
> +
> +	rc = hid_add_device(hid);
> +	if (rc)
> +		goto err_hid_device;
> +
> +	return 0;
> +
> +err_hid_device:
> +	kfree(hid_data);
> +err_hid_data:
> +	hid_destroy_device(hid);
> +	return rc;
> +}
> +
> +void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
> +{
> +	int i;
> +
> +	for (i = 0; i < cli_data->num_hid_devices; ++i) {
> +		kfree(cli_data->feature_report[i]);
> +		kfree(cli_data->input_report[i]);
> +		kfree(cli_data->report_descr[i]);
> +		if (cli_data->hid_sensor_hubs[i]) {
> +			kfree(cli_data->hid_sensor_hubs[i]-
> >driver_data);
> +			hid_destroy_device(cli_data-
> >hid_sensor_hubs[i]);
> +			cli_data->hid_sensor_hubs[i] = NULL;
> +		}
> +	}
> +}
> diff --git a/drivers/hid/amd-sfh-hid/amdsfh-hid.h b/drivers/hid/amd-
> sfh-hid/amdsfh-hid.h
> new file mode 100644
> index 0000000..8bbe40c
> --- /dev/null
> +++ b/drivers/hid/amd-sfh-hid/amdsfh-hid.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD MP2 Sensors transport  driver
> + *
> + * Authors: Sandeep Singh <sandeep.singh@amd.com>
> + *          Nehal Bakulchandra Shah <Nehal-bakulchandra.shah@amd.com
> >
> + */
> +
> +#ifndef AMDSFH_HID_H
> +#define AMDSFH_HID_H
> +#include <linux/debugfs.h>
> +
> +#define MAX_HID_DEVICES		4
> +#define DCD_DATA_SIZE_CHAR	512
> +#define BUS_AMD_AMDTP		0x20
> +#define AMD_SFH_HID_VENDOR	1022
> +#define AMD_SFH_HID_PRODUCT	0x0001
> +#define AMD_SFH_HID_VERSION	0x0001
> +
> +struct amdtp_cl_device {
> +	struct pci_dev *pdev;
> +	struct amdtp_cl_data *cl_data;
> +};
> +
> +struct amdtp_cl_data {
> +	u8 init_done;
> +	unsigned int cur_hid_dev;
> +	unsigned int hid_dev_count;
> +	unsigned int num_hid_devices;
> +	struct device_info *hid_devices;
> +	unsigned char *report_descr[MAX_HID_DEVICES];
> +	int report_descr_size[MAX_HID_DEVICES];
> +	struct hid_device *hid_sensor_hubs[MAX_HID_DEVICES];
> +	unsigned char *hid_descr[MAX_HID_DEVICES];
> +	int hid_descr_size[MAX_HID_DEVICES];
> +	phys_addr_t phy_addr_base;
> +	u32 *sensor_virt_addr[MAX_HID_DEVICES];
> +	phys_addr_t sensor_phy_addr[MAX_HID_DEVICES];
> +	u32 sensor_sts[MAX_HID_DEVICES];
> +	u32 sensor_requested_cnt[MAX_HID_DEVICES];
> +	u8 report_type[MAX_HID_DEVICES];
> +	u8 report_id[MAX_HID_DEVICES];
> +	u8 sensor_idx[MAX_HID_DEVICES];
> +	u8 *feature_report[MAX_HID_DEVICES];
> +	u8 *input_report[MAX_HID_DEVICES];
> +	u8 request_done[MAX_HID_DEVICES];
> +	struct delayed_work work;
> +	struct delayed_work work_buffer;
> +	struct dentry *amd_debugfs_dir;
> +
> +};
> +
> +/**
> + * struct amdtp_hid_data - Per instance HID data
> + * @index:		Device index in the order of enumeration
> + * @request_done:	Get Feature/Input report complete flag
> + *			used during get/set request from hid core
> + * @cli_data:		Link to the client instance
> + * @hid_wait:		Completion waitq
> + *
> + * Used to tie hid hid->driver data to driver client instance
> + */
> +struct amdtp_hid_data {
> +	int index;
> +	struct amdtp_cl_data *cli_data;
> +	wait_queue_head_t hid_wait;
> +};
> +
> +/* Interface functions between HID LL driver and AMD SFH client */
> +void hid_amdtp_set_feature(struct hid_device *hid, char *buf,
> unsigned int len,
> +			   int report_id);
> +void hid_amdtp_get_report(struct hid_device *hid, int report_id,
> +			  int report_type);
> +int amdtp_hid_probe(unsigned int cur_hid_dev,
> +		    struct amdtp_cl_data *cli_data);
> +void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
> +void amd_sfh_get_report(struct hid_device *hid, int report_id,
> +			int report_type);
> +void amd_sfh_set_report(struct hid_device *hid, int report_id,
> +			int report_type);
> +void amdtp_hid_wakeup(struct hid_device *hid);
> +
> +#define amd_sfh_cldata(__work) container_of(__work,\
> +					struct amdtp_cl_data,
> work.work)
> +#endif	/* AMDSFH_HID */

